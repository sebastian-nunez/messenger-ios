//
//  InboxServiceImpl.swift
//  Messenger
//
//  Created by Sebastian on 1/1/24.
//

import Firebase
import Foundation

class InboxServiceImpl: InboxService {
    @Published var documentChanges = [DocumentChange]()

    func observeRecentMessages() {
        // ensure we have a user session
        guard let uid = Auth.auth().currentUser?.uid else {
            print("DEBUG: no user session, unable to fetch recent messages")
            return
        }

        // recent messages query
        let query = FirestoreConstants.MessagesCollection
            .document(uid)
            .collection(FirestoreConstants.RecentMessagesCollectionName)
            .order(by: "timestamp", descending: true)

        // add snapshot listener for changes
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ change in
                change.type == .added || change.type == .modified // users could start a new conversation or continue an existing
            }) else {
                return
            }

            print("DEBUG: registering recent messages for user ID \(uid)")
            self.documentChanges = changes
        }
    }
}
