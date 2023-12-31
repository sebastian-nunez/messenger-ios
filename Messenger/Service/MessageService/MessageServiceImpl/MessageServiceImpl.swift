//
//  MessageServiceImpl.swift
//  Messenger
//
//  Created by Sebastian on 12/31/23.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

struct MessageServiceImpl: MessageService {
    static let messagesCollection = Firestore.firestore().collection("messages")

    static func sendMessage(to user: User, _ messageText: String) {
        // ensure we have a valid user session
        guard let currentUid = Auth.auth().currentUser?.uid else { // "fromId"
            print("DEBUG: no user current logged in. Unable to send message!")
            return
        }
        let chatPartnerId = user.id // "toId"

        // two way references between the user sending and the user recieving the message
        let currentUserRef = messagesCollection.document(currentUid).collection(chatPartnerId).document() // create the message document ONCE and share it across the to and from user
        let chatPartnerRef = messagesCollection.document(chatPartnerId).collection(currentUid)
        let messageId = currentUserRef.documentID

        // create the message
        let message = Message(fromId: currentUid,
                              toId: chatPartnerId,
                              messageText: messageText,
                              timestamp: Timestamp())

        // encode the message
        guard let messageData = try? Firestore.Encoder().encode(message) else {
            print("DEBUG: unable to encode the message text")
            return
        }

        // upload the message
        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageId).setData(messageData) // create the SAME message within the chat partner's collection

        print("DEBUG: user ID \(currentUid) sent a message to user ID \(chatPartnerId)")
    }
}
