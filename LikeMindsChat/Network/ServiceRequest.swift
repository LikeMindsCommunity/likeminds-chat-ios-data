//
//  ServiceRequest.swift
//  CollabMates
//
//  Created by Likemind on 14/04/21.
//  Copyright © 2021 CollabMates. All rights reserved.
//

import Alamofire
import Foundation

class ServiceRequest {

  static func httpHeaders() -> HTTPHeaders {
    let accessToken = TokenManager.shared.accessToken ?? ""
    let buildVersion = BuildManager.buildVersion
    return [
      "x-platform-code": "ios",
      "x-version-code": buildVersion,
      "Cookie": "",
      "x-sdk-source": "chat",
      "Authorization": "Bearer " + accessToken,
    ]
  }

  static func httpHeadersWithAPIVersion(extraHeaders: HTTPHeaders? = nil) -> HTTPHeaders {
    var headers = httpHeaders()
    headers["x-api-version"] = "1"
    if let extraHeaders {
      extraHeaders.forEach { header in
        headers[header.name] = header.value
      }
    }
    return headers
  }

  static func httpHeadersWithAcceptVersionV2() -> HTTPHeaders {
    var headers = httpHeaders()
    headers["x-accept-version"] = "v2"
    return headers
  }

  static func deviceRegisterHeaders(headerKey: String = "x-api-key", value: String = "")
    -> HTTPHeaders
  {
    var headers = Self.httpHeaders()
    headers[headerKey] = value
    return headers
  }

  static func httpSdkHeaders(headerKey: String = "x-api-key", value: String = "") -> HTTPHeaders {
    let sdkApiKey = value.isEmpty ? "" : value
    let buildVersion = BuildManager.buildVersion
    return [
      "\(headerKey)": sdkApiKey,
      "x-platform-code": "ios",
      "x-version-code": buildVersion,
      "Cookie": "",
      "x-sdk-source": "chat",
      "Cookie": "",
      "x-api-version": "1",
    ]
  }

  static func cancelRequests(withModuleName moduleName: String) {
    DataNetwork.shared.cancelAllDownloads(for: moduleName)
  }

  static func requestParameters(encodedData: Data) -> Alamofire.Parameters {
    let json = try? JSONSerialization.jsonObject(with: encodedData, options: .fragmentsAllowed)
    guard let params = json as? Alamofire.Parameters else {
      return [:]
    }
    return params
  }

}

func jsonParser(from object: Any) -> String? {
    if let encodable = object as? Encodable {
        let jsonData = try? JSONEncoder().encode(encodable)
        return jsonData?.asString
    }
    
    guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
        return nil
    }
    return String(data: data, encoding: String.Encoding.utf8)
}

extension Encodable {
  func requestParam() -> Alamofire.Parameters {
    let jsonData = try? JSONEncoder().encode(self)
    guard let data = jsonData else {
      return [:]
    }
    return ServiceRequest.requestParameters(encodedData: data)
  }

  var jsonString: NSString {
    let jsonData = try? JSONEncoder().encode(self)
    guard let data = jsonData else { return "" }
    return NSString(string: data.asString)
  }
}

extension Data {
  var asString: String {
    let string = String(data: self, encoding: .utf8)
    return string ?? "Unable to generate string from the given data."
  }
}
