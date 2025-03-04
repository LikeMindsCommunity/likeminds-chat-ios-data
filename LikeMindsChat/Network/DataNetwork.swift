//
//  Network.swift
//  CollabMates
//
//  Created by Likemind on 14/04/21.
//  Copyright © 2021 CollabMates. All rights reserved.
//

import Alamofire
import Foundation

/// Extension on `Data` to provide convenience methods for converting `Data` to a JSON string representation.
extension Data {

    /// Converts `Data` to a `String` in `.utf8` encoding. Returns `"Error in parsing"` if encoding fails.
    func jsonString() -> String {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8) {
            return JSONString
        }
        return "Error in parsing"
    }

    /// Converts `Data` to a pretty-printed JSON string (`NSString`), or returns `nil` if serialization fails.
    var prettyPrintedJSONString: NSString? {
        // Attempt to decode the data into a JSON object, then re-encode with `.prettyPrinted` for formatting
        guard
            let object = try? JSONSerialization.jsonObject(
                with: self, options: []),
            let data = try? JSONSerialization.data(
                withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = NSString(
                data: data, encoding: String.Encoding.utf8.rawValue)
        else {
            return nil
        }
        return prettyPrintedString
    }
}

/// A typealias for a success handler used in networking calls.
typealias SuccessCompletionBlock = (_ moduleName: String, _ responseData: Any?)
    -> Void

/// A typealias for a failure handler used in networking calls.
typealias FailureCompletionBlock = (
    _ moduleName: String, _ error: NetworkServiceError
) -> Void

/// `NetworkServiceError` enumerates different error states that can occur while performing network operations.
enum NetworkServiceError: Error {
    case noError
    case noInternet
    case inaccessible
    case urlError(URLError)
    case generalError(Swift.Error)
    case noResponse
    case invalidResponseType(URLResponse)
    case noResponseData(HTTPURLResponse)
    case endpointError(HTTPURLResponse, Data?)
    case tokenExpire
    case failedJsonParse(_ errorMessage: String)
}

/// A struct that holds all parameters and callbacks relevant to a given request.
///
/// - Note: This helps track the original `DataRequest`, success block, failure block, and module name.
struct RequestParam {
    let successCallback: SuccessCompletionBlock
    let failureCallback: FailureCompletionBlock
    let request: DataRequest
    let moduleName: String
}

/// `DataNetwork` is a singleton class responsible for sending network requests via Alamofire,
/// handling potential retries, token refresh flows, and capturing references to in-flight requests.
///
/// - Important:
///   - This class uses `LMNetworkInterceptor` internally for retry logic.
///   - Each request can optionally handle token refresh if a 401 status code is returned.
internal final class DataNetwork {

    /// Shared static instance for global usage of `DataNetwork`.
    static let shared = DataNetwork()

    /**
     A custom `Session` configured to use our `LMNetworkInterceptor`.

     - The interceptor implements an exponential backoff retry mechanism for certain HTTP status codes.
     */
    private let session: Session = {
        // Create a default URL session configuration from Alamofire.
        let configuration = URLSessionConfiguration.af.default

        // Instantiate our custom retry interceptor.
        let interceptor = LMNetworkInterceptor()

        // Create and return a Session that uses the interceptor.
        return Session(configuration: configuration, interceptor: interceptor)
    }()

    /**
     An array of `RequestParam` representing active or queued requests.

     - Use this array to track requests per `moduleName`, for cancellation or other tracking purposes.
     */
    var downloadResourceParams: [RequestParam]?

    /// Private initializer to enforce singleton usage.
    fileprivate init() {}

    /**
     Cancels all pending download requests associated with a given module name.

     - Parameter moduleName: Name used to group network calls (e.g., for a particular feature).
     */
    func cancelAllDownloads(for moduleName: String) {
        guard let index = indexForModuleName(moduleName),
            let resourceParams = downloadResourceParams
        else {
            return
        }
        let request = resourceParams[index].request
        request.cancel()
    }

    /**
     Cancels all pending download requests for every module.

     - Note: Removes all entries from `downloadResourceParams`.
     */
    func cancelAllDownloads() {
        guard let params = downloadResourceParams else { return }
        var resourceParams = params

        // Cancel each tracked request
        for param in resourceParams {
            param.request.cancel()
        }
        resourceParams.removeAll()
        downloadResourceParams = nil
    }

    /**
     Finds the array index of a request entry matching a particular module name, if it exists.

     - Parameter moduleName: The name of the module whose request index is sought.
     - Returns: The index of the request in `downloadResourceParams` if found, else `nil`.
     */
    func indexForModuleName(_ moduleName: String) -> Array<RequestParam>.Index?
    {
        guard let params = downloadResourceParams else {
            return nil
        }
        let downloadParamIndex = params.firstIndex { downloadParam -> Bool in
            return downloadParam.moduleName == moduleName
        }
        return downloadParamIndex
    }

    /**
     Sends a network request with optional parameters, using an interceptor-based session for retries and token handling.

     - Parameters:
       - url: The endpoint URL.
       - httpMethod: The HTTP method (e.g., `.get`, `.post`, etc.).
       - headers: HTTP headers to send along with the request.
       - parameters: Query or body parameters (default is `nil`).
       - encoding: The parameter encoding strategy (e.g., `URLEncoding.default`).
       - moduleName: A name to categorize this request, useful for cancellation or tracking.
       - successCallback: A closure invoked on success. Returns `moduleName` and `Any?` data.
       - failureCallback: A closure invoked on failure, returning a `NetworkServiceError`.
     */
    func request(
        for url: URL,
        withHTTPMethod httpMethod: Alamofire.HTTPMethod,
        headers: HTTPHeaders,
        withParameters parameters: Parameters? = nil,
        withEncoding encoding: ParameterEncoding,
        withModuleName moduleName: String,
        successCallback: @escaping SuccessCompletionBlock,
        failureCallback: @escaping FailureCompletionBlock
    ) {

        // Ensure we are not offline
        guard Reachability.currentReachabilityStatus != .notReachable else {
            failureCallback(moduleName, .noInternet)
            return
        }

        // Create the `DataRequest` using the custom `session`.
        let request = session.request(
            url,
            method: httpMethod,
            parameters: parameters,
            encoding: encoding,
            headers: headers)

        // Lazily initialize the array if needed.
        if downloadResourceParams == nil {
            downloadResourceParams = []
        }

        // Keep track of this request so we can handle cancellation and references.
        downloadResourceParams?.append(
            RequestParam(
                successCallback: successCallback,
                failureCallback: failureCallback,
                request: request,
                moduleName: moduleName)
        )

        // Handle response from the server
        request.responseData { [weak self] response in

            // Log request information for debugging
            lmLog("\n===Request Start===\n")
            lmLog("Module: \(moduleName)")
            lmLog(request.cURLDescription())
            lmLog("Response status: \(response.response?.statusCode ?? 0)")
            lmLog("\n===Request End===\n")

            // If data is nil, handle the failure
            guard let responseData = response.data else {
                lmLog("failureCallback - \(response)")

                // Original code re-calls the same request on `.sessionTaskFailed`
                // This logic is separate from our interceptor-based approach (can keep or remove).
                if let error = response.error {
                    switch error {
                    case .sessionTaskFailed:
                        self?.request(
                            for: url,
                            withHTTPMethod: httpMethod,
                            headers: headers,
                            withParameters: parameters,
                            withEncoding: encoding,
                            withModuleName: moduleName,
                            successCallback: successCallback,
                            failureCallback: failureCallback)
                        return
                    default:
                        break
                    }
                }

                failureCallback(moduleName, .noResponse)
                lmLog("--------------------------")
                return
            }

            // Handle 401 for token refresh
            if let httpResponse = response.response,
                httpResponse.statusCode == 401
            {

                // If refresh token also fails, it implies token is completely expired
                if url.absoluteString.contains("user/refresh") {
                    TokenManager.shared.onRefreshTokenExpired()
                } else {
                    // Refresh Access Token using existing refresh token
                    TokenManager.shared.refreshAccessToken {
                        [weak self] newAccessToken in
                        var newHeaders = headers
                        newHeaders["Authorization"] =
                            "Bearer \(newAccessToken ?? "")"

                        // Re-make the request with the new token
                        self?.request(
                            for: url,
                            withHTTPMethod: httpMethod,
                            headers: newHeaders,
                            withParameters: parameters,
                            withEncoding: encoding,
                            withModuleName: moduleName,
                            successCallback: successCallback,
                            failureCallback: failureCallback)
                    }
                }
                return
            }

            // Log the response data
            let jsondataString = responseData.jsonString()
            lmLog("response - \(String(describing: jsondataString))")
            lmLog("--------------------------")

            // If everything is valid, call the success callback
            successCallback(moduleName, responseData)
        }
    }

    /**
     Sends a network request and attempts to decode the response JSON into the provided `objectType`.
     Also uses the interceptor-based session for handling retries and token logic.

     - Parameters:
       - url: The endpoint URL.
       - httpMethod: The HTTP method (e.g., `.get`, `.post`, etc.).
       - headers: HTTP headers to send along with the request.
       - parameters: Query or body parameters (default is `nil`).
       - encoding: The parameter encoding strategy (e.g., `URLEncoding.default`).
       - objectType: The `Decodable` type to parse the response into.
       - moduleName: A name to categorize this request, useful for cancellation or tracking.
       - successCallback: A closure invoked on success. Returns `moduleName` and decoded data.
       - failureCallback: A closure invoked on failure, returning a `NetworkServiceError`.
     */
    func requestWithDecoded<T: Decodable>(
        for url: URL,
        withHTTPMethod httpMethod: Alamofire.HTTPMethod,
        headers: HTTPHeaders,
        withParameters parameters: Parameters? = nil,
        withEncoding encoding: ParameterEncoding,
        withResponseType objectType: T.Type,
        withModuleName moduleName: String,
        successCallback: @escaping SuccessCompletionBlock,
        failureCallback: @escaping FailureCompletionBlock
    ) {

        // Ensure we are not offline
        guard Reachability.currentReachabilityStatus != .notReachable else {
            failureCallback(moduleName, .noInternet)
            return
        }

        // Create the `DataRequest` using the custom `session`.
        let request = session.request(
            url,
            method: httpMethod,
            parameters: parameters,
            encoding: encoding,
            headers: headers)

        // Lazily initialize the array if needed.
        if downloadResourceParams == nil {
            downloadResourceParams = []
        }

        // Keep track of this request so we can handle cancellation and references.
        downloadResourceParams?.append(
            RequestParam(
                successCallback: successCallback,
                failureCallback: failureCallback,
                request: request,
                moduleName: moduleName)
        )

        // Handle the response from the server
        request.responseData { [weak self] response in

            // Log request information for debugging
            lmLog("\n===Request Start===\n")
            lmLog("Module: \(moduleName)")
            lmLog(request.cURLDescription())
            lmLog("Response status: \(response.response?.statusCode ?? 0)")
            lmLog("\n===Request End===\n")

            // If data is nil, handle the failure
            guard let responseData = response.data else {
                lmLog("failureCallback - \(response)")

                // Optionally retry manually on `.sessionTaskFailed` (separate from interceptor logic).
                if let error = response.error {
                    switch error {
                    case .sessionTaskFailed:
                        self?.requestWithDecoded(
                            for: url,
                            withHTTPMethod: httpMethod,
                            headers: headers,
                            withParameters: parameters,
                            withEncoding: encoding,
                            withResponseType: objectType,
                            withModuleName: moduleName,
                            successCallback: successCallback,
                            failureCallback: failureCallback)
                        return
                    default:
                        break
                    }
                }
                failureCallback(moduleName, .noResponse)
                lmLog("--------------------------")
                return
            }

            // Handle 401 for token refresh
            if let httpResponse = response.response,
                httpResponse.statusCode == 401
            {

                if url.absoluteString.contains("user/refresh") {
                    TokenManager.shared.onRefreshTokenExpired()
                } else {
                    // Refresh Access Token using existing refresh token
                    TokenManager.shared.refreshAccessToken {
                        [weak self] newAccessToken in
                        var newHeaders = headers
                        newHeaders["Authorization"] =
                            "Bearer \(newAccessToken ?? "")"

                        // Re-make the request with the new token
                        self?.requestWithDecoded(
                            for: url,
                            withHTTPMethod: httpMethod,
                            headers: newHeaders,
                            withParameters: parameters,
                            withEncoding: encoding,
                            withResponseType: objectType,
                            withModuleName: moduleName,
                            successCallback: successCallback,
                            failureCallback: failureCallback
                        )
                    }
                }
                return
            }

            // Attempt to decode JSON into LMResponse<T>
            do {
                let lmResponse = try JSONDecoder().decode(
                    LMResponse<T>.self, from: responseData)
                lmLog(
                    "response - \(String(describing: responseData.prettyPrintedJSONString))"
                )
                successCallback(moduleName, lmResponse)
            } catch let error {
                // If decoding fails, provide the raw response for debugging
                lmLog(
                    "response - \(String(describing: NSString(data: responseData, encoding: String.Encoding.utf8.rawValue)))"
                )
                lmLog("-----------Error---------------")
                lmLog("error in parsing---> \(error)")
                lmLog("-----------End error---------------")
                failureCallback(
                    moduleName, .failedJsonParse(error.localizedDescription))
            }
            lmLog("--------------------------")
        }
    }
}

/// Logs the provided items to the console if the app’s build environment is set to `.devtest`.
///
/// - Parameter items: A variadic list of items to log.
func lmLog(_ items: Any...) {
    if BuildManager.environment == .devtest {
        print(items)
    }
}
