//
//  ReportClient.swift
//  LMChatCore_iOS
//
//  Created by Pushpendra Singh on 06/03/24.
//

import Foundation

class ReportClient: ServiceRequest {

  let moduleName = "ReportClient"
  static let shared = ReportClient()

  func getReportTags(
    request: GetReportTagsRequest, response: LMClientResponse<GetReportTagsResponse>?
  ) {
    let networkPath = ServiceAPIRequest.NetworkPath.getReportTags(request)
    let endpoint = networkPath.apiURL
    guard let url = endpoint.url else {
      response?(LMResponse.failureResponse("Invalid URL"))
      return
    }

    DataNetwork.shared.requestWithDecoded(
      for: url,
      withHTTPMethod: networkPath.httpMethod,
      headers: ServiceRequest.httpHeaders(),
      withEncoding: networkPath.encoding,
      withResponseType: GetReportTagsResponse.self,
      withModuleName: moduleName
    ) { (moduleName, responseData) in
      guard let data = responseData as? LMResponse<GetReportTagsResponse> else { return }
      response?(data)
    } failureCallback: { (moduleName, error) in
      response?(LMResponse.failureResponse(error.localizedDescription))
    }
  }

  func postReport(request: PostReportRequest, response: LMClientResponse<NoData>?) {
    let networkPath = ServiceAPIRequest.NetworkPath.postReport(request)
    let endpoint = networkPath.apiURL
    guard let url = endpoint.url else {
      response?(LMResponse.failureResponse("Invalid URL"))
      return
    }

    DataNetwork.shared.requestWithDecoded(
      for: url,
      withHTTPMethod: networkPath.httpMethod,
      headers: ServiceRequest.httpHeaders(),
      withParameters: networkPath.parameters,
      withEncoding: networkPath.encoding,
      withResponseType: NoData.self,
      withModuleName: moduleName
    ) { (moduleName, responseData) in
      guard let data = responseData as? LMResponse<NoData> else { return }
      response?(data)
    } failureCallback: { (moduleName, error) in
      response?(LMResponse.failureResponse(error.localizedDescription))
    }
  }

}
