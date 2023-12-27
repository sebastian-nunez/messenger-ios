//
//  UserServiceImpl.swift
//  Messenger
//
//  Created by Sebastian on 12/27/23.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

class UserServiceImpl: UserService {
    static let shared = UserServiceImpl()

    @Published var currentUser: User?

    @MainActor
    func fetchCurrentUser() async throws {
        // get the ID of the current user
        guard let uid = Auth.auth().currentUser?.uid else {
            print("DEBUG: unable to find the current user")
            return
        }

        // fetch the metadata from the current user ID
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()

        // decode the user metadata
        // let user = try Firestore.Decoder().decode(User.self, from: snapshot)
        let user = try snapshot.data(as: User.self)
        print("DEBUG: retrieved data for user with email \(user.email)")

        // set the currentUser
        currentUser = user
    }
}
