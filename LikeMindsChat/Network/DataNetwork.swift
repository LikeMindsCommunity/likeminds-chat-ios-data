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

    /// Converts `Data` to a `String` in `.utf8` encoding.
    /// - Returns: A UTF-8 encoded string of the data, or "Error in parsing" if conversion fails
    func jsonString() -> String {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8) {
            return JSONString
        }
        return "Error in parsing"
    }

    /// Converts `Data` to a pretty-printed JSON string.
    /// - Returns: An `NSString` containing the formatted JSON, or `nil` if JSON serialization fails
    /// - Note: Uses `JSONSerialization` with `.prettyPrinted` option for formatting
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

/// A completion handler for successful network operations.
/// - Parameters:
///   - moduleName: The name of the module that initiated the request
///   - responseData: The response data from the network call, if any
typealias SuccessCompletionBlock = (_ moduleName: String, _ responseData: Any?) -> Void

/// A completion handler for failed network operations.
/// - Parameters:
///   - moduleName: The name of the module that initiated the request
///   - error: The specific network error that occurred
typealias FailureCompletionBlock = (_ moduleName: String, _ error: NetworkServiceError) -> Void

/// Represents various types of network-related errors that can occur during API requests.
enum NetworkServiceError: Error {
    /// No error occurred
    case noError
    /// No internet connection is available
    case noInternet
    /// The resource is not accessible
    case inaccessible
    /// A URL-specific error occurred
    case urlError(URLError)
    /// A general error occurred
    case generalError(Swift.Error)
    /// No response was received from the server
    case noResponse
    /// The response type was not as expected
    case invalidResponseType(URLResponse)
    /// No data was received in the response
    case noResponseData(HTTPURLResponse)
    /// The endpoint returned an error status code
    case endpointError(HTTPURLResponse, Data?)
    /// The authentication token has expired
    case tokenExpire
    /// JSON parsing failed
    case failedJsonParse(_ errorMessage: String)
}

/// A structure representing a network request and its associated callbacks.
struct RequestParam {
    /// The callback to be executed on successful completion
    let successCallback: SuccessCompletionBlock
    /// The callback to be executed on failure
    let failureCallback: FailureCompletionBlock
    /// The actual network request
    let request: DataRequest
    /// The name of the module making the request
    let moduleName: String
}

/// A singleton class responsible for handling all network operations in the SDK.
/// This class manages request lifecycle, token refresh, retries, and response handling.
///
/// Usage Example:
/// ```swift
/// DataNetwork.shared.request(
///     for: url,
///     withHTTPMethod: .get,
///     headers: headers,
///     withModuleName: "ChatModule",
///     successCallback: { moduleName, data in
///         // Handle success
///     },
///     failureCallback: { moduleName, error in
///         // Handle error
///     }
/// )
/// ```
internal final class DataNetwork {

    /// The shared singleton instance of DataNetwork
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

    /// Tracks all active network requests.
    /// - Note: Used for request cancellation and lifecycle management
    var downloadResourceParams: [RequestParam]?

    /// Private initializer to enforce singleton pattern
    private init() {}

    /**
     Cancels all pending network requests for a specific module.
     
     - Parameter moduleName: The name of the module whose requests should be cancelled
     - Note: This will only cancel requests that haven't completed yet
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
     Cancels all pending network requests across all modules.
     
     - Note: This will clear all tracked requests and cancel any in-flight operations
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
     Finds the index of a request for a given module name in the tracked requests array.
     
     - Parameter moduleName: The name of the module to search for
     - Returns: The index of the request if found, nil otherwise
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
     Sends a network request and returns raw response data.
     
     - Parameters:
        - url: The endpoint URL
        - httpMethod: The HTTP method to use (GET, POST, etc.)
        - headers: HTTP headers to include in the request
        - parameters: Optional request parameters
        - encoding: The parameter encoding to use (URL, JSON, etc.)
        - moduleName: The name of the module making the request
        - successCallback: Called when request succeeds
        - failureCallback: Called when request fails
     
     - Note: Automatically handles token refresh on 401 responses
     - Important: Uses exponential backoff for retries via `LMNetworkInterceptor`
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
