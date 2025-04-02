//
//  LastConversationRO.swift
//  LikeMindsChat
//
//  Created by Pushpendra Singh on 02/01/24.
//

import Foundation
import RealmSwift

class LastConversationRO: Object {
    @Persisted(primaryKey: true) var id: String?
    @Persisted var answer: String?
    @Persisted var state: Int?
    @Persisted var createdEpoch: Int?
    @Persisted var chatroomId: String?
    @Persisted var communityId: String?
    @Persisted var deletedBy: String?
    @Persisted var member: MemberRO?
    @Persisted var createdAt: String?
    @Persisted var link: LinkRO?
    @Persisted var date: String?
    @Persisted var attachments: List<AttachmentRO> = List()
    @Persisted var attachmentCount: Int?
    @Persisted var attachmentsUploaded: Bool?
    @Persisted var uploadWorkerUUID: String?
    @Persisted var deletedByMember: MemberRO?
    @Persisted var conversationStatus: ConversationStatus?
    @Persisted var widget: WidgetRO?
    @Persisted var widgetId: String?
    @Persisted var attachmentUploadedEpoch: Int?
}
