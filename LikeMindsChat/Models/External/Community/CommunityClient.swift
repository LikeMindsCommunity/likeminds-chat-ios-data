//
//  CommunityClient.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 15/01/24.
//

import Foundation

class CommunityClient {

  let moduleName = "CommunityClient"
  static let shared = CommunityClient()

  /**
   * Calls the api to get content download settings
   * @throws IllegalArgumentException - when LMChatClient is not instantiated
   * @return GetContentDownloadSettingsResponse - GetContentDownloadSettingsResponse model for getContentDownloadSettings
   */
  func getContentDownloadSettings(_ response: LMClientResponse<GetContentDownloadSettingsResponse>?)
  {
    let networkPath = ServiceAPIRequest.NetworkPath.getContentDownloadSettings
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
      withResponseType: GetContentDownloadSettingsResponse.self,
      withModuleName: moduleName
    ) { (moduleName, responseData) in
      guard let data = responseData as? LMResponse<GetContentDownloadSettingsResponse> else {
        return
      }
      response?(data)
    } failureCallback: { (moduleName, error) in
      response?(LMResponse.failureResponse(error.localizedDescription))
    }
  }

  func getCurrentMember() -> Member? {
    guard let user = CommunityDBService.shared.getUser() else {
      return nil
    }
    return Member.Builder()
      .id(user.id ?? "")
      .userUniqueId(user.userUniqueId ?? "")
      .name(user.name ?? "")
      .imageUrl(user.imageUrl ?? "")
      .customTitle(user.customTitle)
      .communityId("\(user.communityId ?? 0)")
      .isGuest(user.isGuest ?? false)
      .sdkClientInfo(ModelConverter.shared.convertSDKClientInfoRO(user.sdkClientInfoRO))
      .uuid(user.uuid ?? "")
      .build()
  }

  func getMember(request: GetMemberRequest) -> GetMemberResponse? {
    guard let memberRO = CommunityDBService.shared.getMember(uuid: request.uuid) else { return nil }
    let response = GetMemberResponse(member: ModelConverter.shared.convertMemberRO(memberRO))
    return response
  }

  func getLoggedInUser() -> User? {
    guard let user = CommunityDBService.shared.getUser() else { return nil }
    let loggedInUser = ModelConverter.shared.convertUserRO(user)
    return loggedInUser
  }

  func getMemberState(response: LMClientResponse<GetMemberStateResponse>?) {
    let networkPath = ServiceAPIRequest.NetworkPath.getMemberState
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
      withResponseType: GetMemberStateResponse.self,
      withModuleName: moduleName
    ) { (moduleName, responseData) in
      guard let data = responseData as? LMResponse<GetMemberStateResponse> else { return }
      response?(data)
    } failureCallback: { (moduleName, error) in
      response?(LMResponse.failureResponse(error.localizedDescription))
    }
  }

  func getAllMembers(
    request: GetAllMembersRequest, response: LMClientResponse<GetAllMembersResponse>?
  ) {
    let networkPath = ServiceAPIRequest.NetworkPath.getAllMembers(request)
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
      withResponseType: GetAllMembersResponse.self,
      withModuleName: moduleName
    ) { (moduleName, responseData) in
      guard let data = responseData as? LMResponse<GetAllMembersResponse> else { return }
      response?(data)
    } failureCallback: { (moduleName, error) in
      response?(LMResponse.failureResponse(error.localizedDescription))
    }
  }

  func searchMembers(
    request: SearchMembersRequest, response: LMClientResponse<SearchMembersResponse>?
  ) {
    let networkPath = ServiceAPIRequest.NetworkPath.searchMembers(request)
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
      withResponseType: SearchMembersResponse.self,
      withModuleName: moduleName
    ) { (moduleName, responseData) in
      guard let data = responseData as? LMResponse<SearchMembersResponse> else { return }
      response?(data)
    } failureCallback: { (moduleName, error) in
      response?(LMResponse.failureResponse(error.localizedDescription))
    }
  }

}
