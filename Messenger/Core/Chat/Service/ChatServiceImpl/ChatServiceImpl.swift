//
//  ChatServiceImpl.swift
//  Messenger
//
//  Created by Sebastian on 12/31/23.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

struct ChatServiceImpl: ChatService {
    var chatPartner: User

    // TODO: extract into a separate file with all Firestore collections
    private let messagesCollection = Firestore.firestore().collection("messages")

    /// Sends a message from the currently logged in user to a target "chat partner".
    func sendMessage(_ messageText: String) {
        // ensure we have a valid user session
        guard let currentUid = Auth.auth().currentUser?.uid else { // "fromId"
            print("DEBUG: no user current logged in. Unable to send message!")
            return
        }
        let chatPartnerId = chatPartner.id // "toId"

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

    /// Listens for messages between the currently logged in user and their chat partner using a completing handler.
    func observeMessages(completion: @escaping ([Message]) -> Void) {
        // get the current user
        guard let currentUid = Auth.auth().currentUser?.uid else {
            print("DEBUG: no current user in session. Unable to observe messages!")
            return
        }
        let chatPartnerId = chatPartner.id

        // query the conversation/messages
        let query = messagesCollection
            .document(currentUid)
            .collection(chatPartnerId) // grab all messages between current user and their chat partner
            .order(by: "timestamp", descending: false)

        // add the snapshot listener: whenever a new message is added, we will be notified
        query.addSnapshotListener { snapshot, _ in
            // detect changes and keep only "ADD" changes when messages are created/sent
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else {
                print("DEBUG: no added changes detected for messages between user ID \(currentUid) and user ID \(chatPartnerId)")
                return
            }

            // go through all "new" messages and decode them
            var messages = changes.compactMap { change in
                try? change.document.data(as: Message.self)
            }

            // attach the User OBJECT to the message associated with the user who sent the messages
            for (index, message) in messages.enumerated() where message.fromId != currentUid { // skip messages from the current user
                messages[index].user = chatPartner
            }

            // send back the messages
            completion(messages)
        }
    }
}
