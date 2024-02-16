//
//  Network.swift
//  CollabMates
//
//  Created by Likemind on 14/04/21.
//  Copyright © 2021 CollabMates. All rights reserved.
//

import Foundation
import Alamofire

extension Data
{
    func jsonString() -> String
    {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8)
        {
            return JSONString
        }
        return "Error in parsing"
    }
    
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}

typealias SuccessCompletionBlock = (_ moduleName: String, _ responseData: Any?) -> Void
typealias FailureCompletionBlock = (_ moduleName: String, _ error: NetworkServiceError) -> Void

enum NetworkServiceError:Error  {
    ///    no error
    case noError
    ///    no internet
    case noInternet
    ///    When network conditions are so bad that after `maxRetries` the request did not succeed.
    case inaccessible
    ///    `URLSession` errors are passed-through, handle as appropriate.
    case urlError(URLError)
    ///    URLSession returned an `Error` object which is not `URLError`
    case generalError(Swift.Error)
    ///    When no `URLResponse` is returned but also no `URLError` or any other `Error` instance.
    case noResponse
    ///    When `URLResponse` is not `HTTPURLResponse`.
    case invalidResponseType(URLResponse)
    ///    Status code is in `200...299` range, but response body is empty. This can be both valid and invalid, depending on HTTP method and/or specific behavior of the service being called.
    case noResponseData(HTTPURLResponse)
    ///    Status code is `400` or higher thus return the entire `HTTPURLResponse` and `Data` so caller can figure out what happened.
    case endpointError(HTTPURLResponse, Data?)
    ///  token expire
    case tokenExpire
    /// Parsing error
    case failedJsonParse(_ errorMessage: String)
}

struct RequestParam {
    let successCallback:SuccessCompletionBlock
    let failureCallback:FailureCompletionBlock
    let request: DataRequest
    let moduleName:String
}

internal final class DataNetwork {
    
    static let shared = DataNetwork()
    var downloadResourceParams:[RequestParam]?
    
    fileprivate init() {}
    
    func cancelAllDownloads(for moduleName:String) {
        guard let index = indexForModuleName(moduleName) else { return }
        guard let resourceParams = downloadResourceParams else { return }
        let request = resourceParams[index].request
        request.cancel()
    }
    
    func cancelAllDownloads() {
        guard let params = downloadResourceParams else {return}
        var resourceParams = params
        for param in resourceParams {
            let dataRequest = param.request
            dataRequest.cancel()
        }
        resourceParams.removeAll()
        downloadResourceParams = nil
    }
    
    func indexForModuleName(_ moduleName: String) -> Array<RequestParam>.Index? {
        guard let params = downloadResourceParams else {
            return nil
        }
        let downloadParamIndex = params.firstIndex { downloadParam -> Bool in
            return downloadParam.moduleName == moduleName
        }
        return downloadParamIndex
    }
    
    func request(for url:URL, withHTTPMethod httpMethod: Alamofire.HTTPMethod, headers: HTTPHeaders, withParameters parameters: Parameters? = nil, withEncoding encoding: ParameterEncoding, withModuleName moduleName:String, successCallback:@escaping SuccessCompletionBlock, failureCallback:@escaping FailureCompletionBlock) {
        guard Reachability.currentReachabilityStatus != .notReachable else {
            failureCallback(moduleName, .noInternet)
            return
        }
        
        let request = AF.request(url,
                                 method: httpMethod,
                                 parameters: parameters,
                                 encoding: encoding,
                                 headers: headers)
        
        downloadResourceParams?.append(RequestParam(successCallback: successCallback, failureCallback: failureCallback, request: request, moduleName: moduleName))
        
        request.responseData { (response) in
            lmLog("--------------------------")
            lmLog("url - \(url)")
            lmLog("request - \(request)")
            lmLog("moduleName - \(moduleName)")
            if let urlRequest = request.request, let httpBody = urlRequest.httpBody {
                debugPrint("http request body - \(String(describing: String(data: httpBody, encoding: .utf8)))")
            }
            lmLog("headers - \(headers)")
            guard let responseData = response.data else {
                lmLog("failureCallback - \(response)")
                if let error = response.error {
                    switch error {
                    case .sessionTaskFailed:
                        self.request(for: url, withHTTPMethod: httpMethod, headers: headers, withParameters: parameters, withEncoding: encoding, withModuleName: moduleName, successCallback: successCallback, failureCallback: failureCallback)
                        return
                    default:
                        break
                    }
                }
                failureCallback(moduleName, .noResponse)
                lmLog("--------------------------")
                return
            }
            let jsondataString = responseData.jsonString()
            if let httpResponse = response.response,
               httpResponse.statusCode == 401,
               jsondataString.range(of: "Invalid LTM!") != nil
            {
                lmLog("response - \(String(describing: jsondataString))")
                TokenManager.shared.refreshInterceptor {}
                failureCallback(moduleName, .tokenExpire)
                return
            }
            lmLog("response - \(String(describing: jsondataString))")
            lmLog("--------------------------")
            successCallback(moduleName, responseData)
        }
    }
    
    func requestWithDecoded<T: Decodable>(for url:URL, withHTTPMethod httpMethod: Alamofire.HTTPMethod, headers: HTTPHeaders, withParameters parameters: Parameters? = nil, withEncoding encoding: ParameterEncoding, withResponseType objectType: T.Type, withModuleName moduleName:String, successCallback:@escaping SuccessCompletionBlock, failureCallback:@escaping FailureCompletionBlock) {
        guard Reachability.currentReachabilityStatus != .notReachable else {
            failureCallback(moduleName, .noInternet)
            return
        }
        let request = AF.request(url,
                                 method: httpMethod,
                                 parameters: parameters,
                                 encoding: encoding,
                                 headers: headers)
        
        downloadResourceParams?.append(RequestParam(successCallback: successCallback, failureCallback: failureCallback, request: request, moduleName: moduleName))
        
        request.responseData { (response) in
            lmLog("--------------------------")
            lmLog("url - \(url)")
            lmLog("request - \(request)")
            lmLog("moduleName - \(moduleName)")
            if let urlRequest = request.request, let httpBody = urlRequest.httpBody {
                debugPrint("http request body - \(String(describing: String(data: httpBody, encoding: .utf8)))")
            }
            lmLog("headers - \(headers)")
            guard let responseData = response.data else {
                lmLog("failureCallback - \(response)")
                if let error = response.error {
                    switch error {
                    case .sessionTaskFailed:
                        self.request(for: url, withHTTPMethod: httpMethod, headers: headers, withParameters: parameters, withEncoding: encoding, withModuleName: moduleName, successCallback: successCallback, failureCallback: failureCallback)
                        return
                    default:
                        break
                    }
                }
                failureCallback(moduleName, .noResponse)
                lmLog("--------------------------")
                return
            }
            
            if let httpResponse = response.response,
               httpResponse.statusCode == 401
            {
                let jsondataString = responseData.jsonString()
                if jsondataString.range(of: "Invalid LTM!") != nil {
                    lmLog("response - \(String(describing: jsondataString))")
                    TokenManager.shared.refreshInterceptor {}
                    failureCallback(moduleName, .tokenExpire)
                    return
                }
                failureCallback(moduleName, .noResponse)
            }
            do {
                let lmResponse  = try JSONDecoder().decode(LMResponse<T>.self, from: responseData)
                lmLog("response - \(String(describing: lmResponse))")
                lmLog("response - \(String(describing: responseData.prettyPrintedJSONString))")
                successCallback(moduleName, lmResponse)
            } catch let error {
                lmLog("response - \(String(describing: responseData.prettyPrintedJSONString))")
                failureCallback(moduleName, .failedJsonParse(error.localizedDescription))
            }
            lmLog("--------------------------")
        }
    }
}

func lmLog(_ items: Any...) {
//    if AppManager.environment == .devtest {
        print(items)
//    LMLogger.info(items)
//    }
}
