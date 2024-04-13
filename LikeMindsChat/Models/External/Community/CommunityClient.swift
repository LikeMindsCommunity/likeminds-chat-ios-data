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
    func getContentDownloadSettings(_ response: LMClientResponse<GetContentDownloadSettingsResponse>?) {
        let networkPath = ServiceAPIRequest.NetworkPath.getContentDownloadSettings
        guard let url:URL = URL(string: ServiceAPI.authBaseURL + networkPath.apiURL) else {return}
        DataNetwork.shared.requestWithDecoded(for: url,
                                              withHTTPMethod: networkPath.httpMethod,
                                              headers: ServiceRequest.httpHeaders(),
                                              withParameters: networkPath.parameters,
                                              withEncoding: networkPath.encoding,
                                              withResponseType: GetContentDownloadSettingsResponse.self,
                                              withModuleName: moduleName) { (moduleName, responseData) in
            guard let data = responseData as? LMResponse<GetContentDownloadSettingsResponse> else {return}
            response?(data)
        } failureCallback: { (moduleName, error) in
            response?(LMResponse.failureResponse(error.localizedDescription))
        }
    }
    
    /**
     * Observes the community stored in DB
     * @throws IllegalArgumentException - when LMChatClient is not instantiated
     * @return Flowable<Optional<Community>> - Flow of community
     */
//    func observeCommunity(community: Observable<Community>) {
//        
//    }
    
    func getMember(request: GetMemberRequest) -> GetMemberResponse? {
        guard let memberRO = CommunityDBService.shared.getMember(uuid: request.uuid) else { return nil }
        let response = GetMemberResponse(member: ModelConverter.shared.convertMemberRO(memberRO))
        return response
    }
    
}
