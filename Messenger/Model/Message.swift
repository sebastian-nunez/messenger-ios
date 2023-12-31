//
//  Message.swift
//  Messenger
//
//  Created by Sebastian on 12/31/23.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

struct Message: Identifiable, Codable, Hashable {
    @DocumentID var messageId: String?

    let fromId: String
    let toId: String
    let messageText: String
    let timestamp: Timestamp
    var user: User?

    var id: String {
        messageId ?? UUID().uuidString
    }

    var chatPartnerId: String {
        fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }

    var isFromCurrentUser: Bool {
        fromId == Auth.auth().currentUser?.uid
    }
}
