//
//  ServiceApiRequest.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 02/05/24.
//

import Alamofire
import Foundation

public struct ServiceAPI {
    static let requestTimeout = TimeInterval(30)
    static let authBaseURL = ServiceConfiguration.authBaseURL
    public static let bucketURL = ServiceConfiguration.bucketURL
    public static let awsPoolIdCognito = ServiceConfiguration.awsPoolIdCognito
    public static let secretAccessKey = ServiceConfiguration.secretAccessKey
    public static let accessKey = ServiceConfiguration.accessKey
}

struct ServiceAPIRequest {

    enum NetworkPath {
        //MARK:- SDK APIs
        case initiateChatClient(_ request: InitiateUserRequest)
        case validateUser(_ request: ValidateUserRequest)
        case refreshServiceToken(rtm: String)
        case pushToken(_ request: RegisterDeviceRequest)
        case logout(_ request: LogoutUserRequest)
        case getConfig
        case sdkOnboarding
        case explorTabCount

        //MARK:- Chatrooms api
        case syncChatrooms(_ request: ChatroomSyncRequest)
        case getChatroomActions(_ request: GetChatroomActionsRequest)
        case followChatroom(_ request: FollowChatroomRequest)
        case leaveSecretChatroom(_ request: LeaveSecretChatroomRequest)
        case muteChatroom(_ request: MuteChatroomRequest)
        case markReadChatroom(_ request: MarkReadChatroomRequest)
        case setChatroomTopic(_ request: SetChatroomTopicRequest)
        case getParticipants(_ request: GetParticipantsRequest)
        case editChatroomTitle(_ request: EditChatroomTitleRequest)
        case getChannelInvites(_ request: GetChannelInvitesRequest)
        case updateChannelInvite(_ request: UpdateChannelInviteRequest)

        //MARK:- Community api
        case explorFeed(_ request: GetExploreFeedRequest)
        case getContentDownloadSettings
        case getMemberState
        case getAllMembers(_ request: GetAllMembersRequest)
        case searchMembers(_ request: SearchMembersRequest)

        //MARK:- Conversation api
        case syncConversations(_ request: ConversationSyncRequest)
        case postConversation(_ request: PostConversationRequest)
        case editConversation(_ request: EditConversationRequest)
        case deleteConversations(_ request: DeleteConversationsRequest)
        case putReaction(_ request: PutReactionRequest)
        case deleteReaction(_ request: DeleteReactionRequest)

        //MARK:- Helper api
        case decodeUrl(_ request: DecodeUrlRequest)
        case getTaggingList(_ request: GetTaggingListRequest)
        case getExploreTabCount

        //MARK:- Poll api
        case postPollConversation(_ request: PostPollConversationRequest)
        case addPollOption(_ request: AddPollOptionRequest)
        case submitPoll(_ request: SubmitPollRequest)
        case getPollUsers(_ request: GetPollUsersRequest)

        //MARK:- Search api
        case searchChatroom(_ request: SearchChatroomRequest)
        case searchConversation(_ request: SearchConversationRequest)

        //MARK:- Report api
        case getReportTags(_ reqeust: GetReportTagsRequest)
        case postReport(_ request: PostReportRequest)

        //MARK: DM Api
        case checkDMTab
        case checkDMStatus(_ request: CheckDMStatusRequest)
        case checkDMLimit(_ request: CheckDMLimitRequest)
        case createDMChatroom(_ request: CreateDMChatroomRequest)
        case fetchDMFeeds(_ request: FetchDMFeedRequest)
        case sendDMRequest(_ request: SendDMRequest)
        case blockDMMember(_ request: BlockMemberRequest)

        //MARK: AIChatBot Api
        case getAIChatbots(_ request: GetAIChatbotsRequest)

        var apiURL: Endpoint {
            let paths = Paths.shared
            let keys = Constant.shared.keys

            switch self {
            case .initiateChatClient, .validateUser:
                return Endpoint(path: paths.sdkInitiate, queryItems: [])

            case .refreshServiceToken:
                return Endpoint(path: paths.userRefresh, queryItems: [])

            case .pushToken:
                return Endpoint(path: paths.userDevicePush, queryItems: [])

            case .logout:
                return Endpoint(path: paths.userLogout, queryItems: [])

            case .getConfig:
                return Endpoint(path: paths.userConfig, queryItems: [])

            case .sdkOnboarding:
                return Endpoint(path: paths.sdkOnboarding, queryItems: [])

            case .explorTabCount, .getExploreTabCount:
                return Endpoint(
                    path: paths.communityMemberHomeMeta,
                    queryItems: []
                )

            case .explorFeed(let request):
                var queryItems = [
                    URLQueryItem(name: keys.page, value: "\(request.page)"),
                    URLQueryItem(
                        name: keys.orderType,
                        value: "\(request.orderType)"
                    ),
                ]

                if let isPinned = request.isPinned {
                    queryItems.append(
                        URLQueryItem(name: keys.pinned, value: "\(isPinned)")
                    )
                }

                return Endpoint(
                    path: paths.communityFeed,
                    queryItems: queryItems
                )

            //MARK: - DM api URL
            case .checkDMTab:
                return Endpoint(path: paths.homeDmMeta, queryItems: [])

            case .fetchDMFeeds(let request):
                let queryItems = [
                    URLQueryItem(name: keys.page, value: "\(request.page)"),
                    URLQueryItem(
                        name: keys.pageSize,
                        value: "\(request.pageSize)"
                    ),
                ]
                return Endpoint(path: paths.chatroomDm, queryItems: queryItems)

            case .checkDMStatus(let request):
                var queryItems = [
                    URLQueryItem(
                        name: keys.reqFrom,
                        value: request.requestFrom?.rawValue ?? ""
                    )
                ]

                if let uuid = request.uuid {
                    queryItems.append(
                        URLQueryItem(name: keys.uuid, value: uuid)
                    )
                }

                if let chatroomId = request.chatroomId {
                    queryItems.append(
                        URLQueryItem(name: keys.chatroomId, value: chatroomId)
                    )
                }

                return Endpoint(
                    path: paths.communityDmStatus,
                    queryItems: queryItems
                )

            case .checkDMLimit(let request):
                let queryItems = [
                    URLQueryItem(name: keys.uuid, value: request.uuid ?? "")
                ]
                return Endpoint(
                    path: paths.chatroomDmLimit,
                    queryItems: queryItems
                )

            case .createDMChatroom:
                return Endpoint(path: paths.chatroomDmCreate, queryItems: [])

            case .sendDMRequest:
                return Endpoint(path: paths.chatroomDmRequest, queryItems: [])

            case .blockDMMember:
                return Endpoint(path: paths.chatroomDmBlock, queryItems: [])

            //MARK: - Chatrooms api URL
            case .syncChatrooms(let request):
                var queryItems = [
                    URLQueryItem(
                        name: keys.isLocalDb,
                        value: "\(request.isLocalDB)"
                    ),
                    URLQueryItem(name: keys.page, value: "\(request.page)"),
                    URLQueryItem(
                        name: keys.pageSize,
                        value: "\(request.pageSize)"
                    ),
                    URLQueryItem(
                        name: keys.minTimestamp,
                        value: "\(request.minTimestamp)"
                    ),
                    URLQueryItem(
                        name: keys.maxTimestamp,
                        value: "\(request.maxTimestamp)"
                    ),
                ]

                if !request.chatroomTypes.isEmpty {
                    queryItems.append(
                        URLQueryItem(
                            name: keys.chatroomTypes,
                            value:
                                "[\(request.chatroomTypes.map({"\($0)"}).joined(separator: ","))]"
                        )
                    )
                }

                return Endpoint(
                    path: paths.chatroomSync,
                    queryItems: queryItems
                )

            case .getChatroomActions(let request):
                let queryItems = [
                    URLQueryItem(
                        name: keys.chatroomId,
                        value: request.chatroomId
                    )
                ]
                return Endpoint(path: paths.chatroom, queryItems: queryItems)

            case .followChatroom:
                return Endpoint(path: paths.chatroomFollow, queryItems: [])

            case .leaveSecretChatroom:
                return Endpoint(
                    path: paths.chatroomParticipants,
                    queryItems: []
                )

            case .muteChatroom:
                return Endpoint(path: paths.chatroomMute, queryItems: [])

            case .markReadChatroom:
                return Endpoint(path: paths.chatroomMarkRead, queryItems: [])

            case .setChatroomTopic:
                return Endpoint(path: paths.conversationTopic, queryItems: [])

            case .getParticipants(let request):
                var queryItems = [
                    URLQueryItem(
                        name: keys.chatroomId,
                        value: request.chatroomId
                    ),
                    URLQueryItem(
                        name: keys.isSecret,
                        value: "\(request.isChatroomSecret)"
                    ),
                    URLQueryItem(name: keys.page, value: "\(request.page)"),
                    URLQueryItem(
                        name: keys.pageSize,
                        value: "\(request.pageSize)"
                    ),
                ]

                if let searchName = request.participantName,
                    !searchName.trimmingCharacters(in: .whitespacesAndNewlines)
                        .isEmpty
                {
                    queryItems.append(
                        URLQueryItem(
                            name: keys.participantName,
                            value: searchName
                        )
                    )
                }

                return Endpoint(
                    path: paths.chatroomParticipants,
                    queryItems: queryItems
                )

            case .editChatroomTitle:
                return Endpoint(path: paths.chatroom, queryItems: [])

            //MARK:- Community api URL
            case .getContentDownloadSettings:
                return Endpoint(
                    path: paths.communitySettingsContentDownload,
                    queryItems: []
                )

            case .getMemberState:
                return Endpoint(
                    path: paths.communityMemberState,
                    queryItems: []
                )

            case .getAllMembers(let request):
                var queryItems = [
                    URLQueryItem(name: keys.page, value: "\(request.page)"),
                    URLQueryItem(
                        name: keys.pageSize,
                        value: "\(request.pageSize)"
                    ),
                ]

                if let memberState = request.memberState {
                    queryItems.append(
                        URLQueryItem(
                            name: keys.memberState,
                            value: "\(memberState)"
                        )
                    )
                }

                if !request.filterMemberRoles.isEmpty {
                    queryItems.append(
                        URLQueryItem(
                            name: keys.filterMemberRoles,
                            value:
                                "[\(request.filterMemberRoles.joined(separator: ","))]"
                        )
                    )
                }

                if let excludeSelf = request.excludeSelfUser {
                    queryItems.append(
                        URLQueryItem(
                            name: keys.excludeSelfUser,
                            value: "\(excludeSelf)"
                        )
                    )
                }

                return Endpoint(
                    path: paths.communityMember,
                    queryItems: queryItems
                )

            case .searchMembers(let request):
                var queryItems = [
                    URLQueryItem(name: keys.page, value: "\(request.page)"),
                    URLQueryItem(
                        name: keys.pageSize,
                        value: "\(request.pageSize)"
                    ),
                    URLQueryItem(
                        name: keys.search,
                        value: request.search ?? ""
                    ),
                    URLQueryItem(
                        name: keys.searchType,
                        value: request.searchType ?? ""
                    ),
                ]

                if let memberState = request.memberState {
                    queryItems.append(
                        URLQueryItem(
                            name: keys.memberStates,
                            value:
                                "[\(memberState.map { "\($0)" }.joined(separator: ","))]"
                        )
                    )
                }

                if let excludeSelf = request.excludeSelfUser {
                    queryItems.append(
                        URLQueryItem(
                            name: keys.excludeSelfUser,
                            value: "\(excludeSelf)"
                        )
                    )
                }

                return Endpoint(
                    path: paths.communityMemberSearch,
                    queryItems: queryItems
                )

            //MARK:- Conversation api URL
            case .postConversation, .editConversation, .deleteConversations,
                .postPollConversation:
                return Endpoint(path: paths.conversation, queryItems: [])

            case .syncConversations(let request):
                var queryItems = [
                    URLQueryItem(name: keys.isLocalDb, value: "true"),
                    URLQueryItem(
                        name: keys.chatroomId,
                        value: request.chatroomId ?? ""
                    ),
                    URLQueryItem(name: keys.page, value: "\(request.page)"),
                    URLQueryItem(
                        name: keys.pageSize,
                        value: "\(request.pageSize)"
                    ),
                    URLQueryItem(
                        name: keys.minTimestamp,
                        value: "\(request.minTimestamp ?? 0)"
                    ),
                    URLQueryItem(
                        name: keys.maxTimestamp,
                        value: "\(request.maxTimestamp ?? 0)"
                    ),
                ]

                if let conversationId = request.conversationId {
                    queryItems.append(
                        URLQueryItem(
                            name: keys.conversationId,
                            value: conversationId
                        )
                    )
                }

                return Endpoint(
                    path: paths.conversationSync,
                    queryItems: queryItems
                )

            case .putReaction, .deleteReaction:
                return Endpoint(
                    path: paths.conversationReaction,
                    queryItems: []
                )

            //MARK:- Helper api URL
            case .decodeUrl(let request):
                let queryItems = [
                    URLQueryItem(name: keys.url, value: request.url)
                ]
                return Endpoint(path: paths.helperUrl, queryItems: queryItems)

            case .getTaggingList(let request):
                var queryItems = [
                    URLQueryItem(
                        name: keys.pageSize,
                        value: "\(request.pageSize)"
                    ),
                    URLQueryItem(name: keys.page, value: "\(request.page)"),
                ]

                if let searchName = request.searchName, !searchName.isEmpty {
                    queryItems.append(
                        URLQueryItem(name: keys.searchName, value: searchName)
                    )
                }

                if !request.chatroomId.isEmpty {
                    queryItems.append(
                        URLQueryItem(
                            name: keys.chatroomId,
                            value: request.chatroomId
                        )
                    )
                }

                return Endpoint(
                    path: paths.communityTag,
                    queryItems: queryItems
                )

            // MARK:- Poll api URL
            case .addPollOption:
                return Endpoint(path: paths.conversationPoll, queryItems: [])

            case .submitPoll:
                return Endpoint(
                    path: paths.conversationPollSubmit,
                    queryItems: []
                )

            case .getPollUsers(let request):
                let queryItems = [
                    URLQueryItem(
                        name: keys.conversationId,
                        value: request.conversationId
                    ),
                    URLQueryItem(
                        name: keys.pollId,
                        value: request.pollOptionId
                    ),
                ]
                return Endpoint(
                    path: paths.conversationPollUsers,
                    queryItems: queryItems
                )

            // MARK: Search Chatroom
            case .searchChatroom(let request):
                let queryItems = [
                    URLQueryItem(
                        name: keys.followStatus,
                        value: "\(request.followStatus)"
                    ),
                    URLQueryItem(name: keys.page, value: "\(request.page)"),
                    URLQueryItem(
                        name: keys.pageSize,
                        value: "\(request.pageSize)"
                    ),
                    URLQueryItem(name: keys.search, value: request.search),
                    URLQueryItem(
                        name: keys.searchType,
                        value: request.searchType
                    ),
                ]
                return Endpoint(
                    path: paths.chatroomSearch,
                    queryItems: queryItems
                )

            // MARK: Search Conversation
            case .searchConversation(let request):
                let queryItems = [
                    URLQueryItem(
                        name: keys.chatroomId,
                        value: request.chatroomId
                    ),
                    URLQueryItem(
                        name: keys.followStatus,
                        value: "\(request.followStatus ?? true)"
                    ),
                    URLQueryItem(name: keys.page, value: "\(request.page)"),
                    URLQueryItem(
                        name: keys.pageSize,
                        value: "\(request.pageSize)"
                    ),
                    URLQueryItem(name: keys.search, value: request.search),
                ]
                return Endpoint(
                    path: paths.conversationSearch,
                    queryItems: queryItems
                )

            // MARK: Report api
            case .getReportTags(let request):
                let queryItems = [
                    URLQueryItem(name: keys.type, value: "\(request.type)")
                ]
                return Endpoint(
                    path: paths.communityReportTag,
                    queryItems: queryItems
                )

            case .postReport:
                return Endpoint(path: paths.communityReport, queryItems: [])

            // MARK: Secret Chatroom Invite
            case .getChannelInvites(let request):
                let queryItems = [
                    URLQueryItem(
                        name: keys.channelType,
                        value: "\(request.channelType)"
                    ),
                    URLQueryItem(name: keys.page, value: "\(request.page)"),
                    URLQueryItem(
                        name: keys.pageSize,
                        value: "\(request.pageSize)"
                    ),
                ]
                return Endpoint(
                    path: paths.channelInvites,
                    queryItems: queryItems
                )

            case .updateChannelInvite(let request):
                let queryItems = [
                    URLQueryItem(
                        name: keys.channelId,
                        value: "\(request.channelId)"
                    ),
                    URLQueryItem(
                        name: keys.inviteStatus,
                        value: "\(request.inviteStatus.rawValue)"
                    ),
                ]
                return Endpoint(
                    path: paths.channelInvite,
                    queryItems: queryItems
                )

            //MARK: AIChatBots
            case .getAIChatbots(let request):
                let queryItems = [
                    URLQueryItem(
                        name: keys.page,
                        value: "\(request.page ?? 1)"
                    ),
                    URLQueryItem(
                        name: keys.pageSize,
                        value: "\(request.pageSize)"
                    ),
                ]
                return Endpoint(
                    path: paths.communityChatbot,
                    queryItems: queryItems
                )
            }
        }

        var httpMethod: Alamofire.HTTPMethod {
            switch self {
            case .initiateChatClient,
                .refreshServiceToken,
                .pushToken,
                .logout,
                .markReadChatroom,
                .postConversation,
                .postPollConversation,
                .addPollOption,
                .submitPoll,
                .createDMChatroom,
                .sendDMRequest,
                .blockDMMember,
                .postReport:
                return .post
            case .validateUser,
                .getConfig,
                .syncChatrooms,
                .syncConversations,
                .sdkOnboarding,
                .explorTabCount,
                .explorFeed,
                .getChatroomActions,
                .getParticipants,
                .getContentDownloadSettings,
                .decodeUrl,
                .getTaggingList,
                .getExploreTabCount,
                .searchChatroom,
                .searchConversation,
                .getPollUsers,
                .getMemberState,
                .getAllMembers,
                .searchMembers,
                .checkDMLimit,
                .checkDMStatus,
                .fetchDMFeeds,
                .checkDMTab,
                .getReportTags,
                .getChannelInvites,
                .getAIChatbots:
                return .get
            case .setChatroomTopic,
                .muteChatroom,
                .followChatroom,
                .editChatroomTitle,
                .putReaction,
                .editConversation,
                .updateChannelInvite:
                return .put
            case .leaveSecretChatroom,
                .deleteReaction,
                .deleteConversations:
                return .delete

            }
        }

        var requestTimeout: TimeInterval {
            switch self {
            default:
                return ServiceAPI.requestTimeout
            }
        }

        var parameters: Alamofire.Parameters? {
            switch self {
            case .initiateChatClient(let request):
                return request.requestParam()
            case .pushToken(let request):
                return request.requestParam()
            case .refreshServiceToken:
                return [:]
            case .logout(let request):
                return request.requestParam()
            case .syncChatrooms(let request):
                return request.requestParam()
            case .followChatroom(let request):
                return request.requestParam()
            case .leaveSecretChatroom(let request):
                return request.requestParam()
            case .muteChatroom(let request):
                return request.requestParam()
            case .markReadChatroom(let request):
                return request.requestParam()
            case .setChatroomTopic(let request):
                return request.requestParam()
            case .editChatroomTitle(let request):
                return request.requestParam()
            case .postConversation(let request):
                return request.requestParam()
            case .editConversation(let request):
                return request.requestParam()
            case .deleteConversations(let request):
                return request.requestParam()
            case .putReaction(let request):
                return request.requestParam()
            case .deleteReaction(let request):
                return request.requestParam()
            case .addPollOption(let request):
                return request.requestParam()
            case .submitPoll(let request):
                return request.requestParam()
            case .postPollConversation(let request):
                return request.requestParam()
            case .postReport(let request):
                return request.requestParam()
            case .blockDMMember(let request):
                return request.requestParam()
            case .createDMChatroom(let request):
                return request.requestParam()
            case .sendDMRequest(let request):
                return request.requestParam()
            case .updateChannelInvite(let request):
                return request.requestParam()
            default:
                return nil
            }
        }

        var encoding: Alamofire.ParameterEncoding {
            switch self {
            default:
                return JSONEncoding.default
            }
        }
    }
}
