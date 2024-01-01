//
//  Constants.swift
//  Messenger
//
//  Created by Sebastian on 12/31/23.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

enum FirestoreConstants {
    static let UsersCollection = Firestore.firestore().collection("users")
    static let MessagesCollection = Firestore.firestore().collection("messages")
    static let RecentMessagesCollectionName = "recent-messages"
}
