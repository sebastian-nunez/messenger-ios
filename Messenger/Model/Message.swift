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

    var timestampString: String {
        timestamp.dateValue().descriptiveFormatString()
    }
}

extension Message {
    static let MOCK_MESSAGE = Message(fromId: "1",
                                      toId: "2",
                                      messageText: "This is a very long test message for now. It expands multiple lines.",
                                      timestamp: Timestamp(),
                                      user: User.MOCK_USER)
}
