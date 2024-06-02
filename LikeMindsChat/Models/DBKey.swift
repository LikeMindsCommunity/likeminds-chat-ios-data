//
//  DBKey.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 07/01/24.
//

import Foundation
import RealmSwift

struct DbKey {
    
    static let ID = "id"
    static let TEMPORARY_ID = "temporaryId"
    static let UID = "uid"
    static let CHATROOM_ID = "chatroomId"
    static let COMMUNITY_ID = "communityId"
    static let CHATROOM = "chatroom"
    static let COMMUNITY = "community"
    static let LAST_SEEN = "lastSeen"
    static let REMOVE_STATE = "removeState"
    static let DELETED_BY = "deletedBy"
    static let DELETED_BY_MEMBER = "deletedByMember"
    static let IS_DRAFT = "isDraft"
    static let IS_OWNER = "isOwner"
    static let IS_GUEST = "isGuest"
    static let UPDATED_AT = "updatedAt"
    static let CREATED_EPOCH = "createdEpoch"
    static let LOCAL_SAVED_EPOCH = "localSavedEpoch"
    static let TOPIC_ID = "topicId"
    
    static let RELATIONSHIP_NEEDED = "relationshipNeeded"
    
    static let CHATROOM_OBJECT_ID = "chatroom.id"
    static let COMMUNITY_OBJECT_ID = "community.id"
    static let MEMBER_OBJECT_ID = "member.id"
    static let MEMBER_OBJECT_UUID = "member.uuid"
    static let MEMBER_OBJECT_UID = "member.uid"
    static let STATE = "state"
    
    static let CHATROOM_EXPIRY_TIME = "chatroomExpiryTime"
    static let CHATROOM_WITH_USER_ID = "chatroomWithUserId"
    static let FOLLOW_STATUS = "followStatus"
    
    static let CONVERSATIONS_LIMIT = 200
    static let INACTIVE_CHATROOM_HOME_LIMIT = 10
    
    static let REPLY_CONVERSATION = "replyConversation"
    static let REPLY_CONVERSATION_ID = "replyConversationId"
    
    static let CHATROOM_HEADER = "header"
    
    static let ANSWER = "answer"
    
    static let NAME = "name"
    
    static let ATTENDING_STATUS = "attendingStatus"
    static let DATE_TIME = "dateTime"
    static let END_DATE = "endDate"
    static let TYPE = "type"
    static let POLL_TYPE_TEXT = "pollTypeText"
    static let UPLOAD_WORKER_UUID = "uploadWorkerUUID"
    static let ATTACHMENTS_UPLOADED = "attachmentsUploaded"
    static let ATTACHMENTS_COUNT = "attachmentCount"
    static let HAS_BEEN_NAMED = "hasBeenNamed"
    static let HEADER = "header"
    static let TITLE = "title"
    static let ANSWER_TEXT = "answerText"
    static let POLLS_COUNT = "pollsCount"
    static let DOWNLOADABLE_CONTENT_TYPES = "downloadableContentTypes"
}
