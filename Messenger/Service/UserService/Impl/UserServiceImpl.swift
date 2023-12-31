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

    @MainActor
    static func fetchAllUsers(limit: Int? = nil) async throws -> [User] {
        // query to apply limit
        let query = FirestoreConstants.UsersCollection

        if let limit = limit {
            query.limit(to: limit)
        }

        // fetch all users
        let snapshot = try await query.getDocuments()

        // decode the users
        let users = snapshot.documents.compactMap { user in
            try? user.data(as: User.self)
        }

        return users
    }

    static func fetchUser(with uid: String, completion: @escaping (User) -> Void) {
        FirestoreConstants.UsersCollection.document(uid).getDocument { snapshot, _ in
            // decode user
            guard let user = try? snapshot?.data(as: User.self) else {
                print("DEBUG: unable to decode the user with ID \(uid)")
                return
            }

            print("DEBUG: retrieved user with ID \(uid)")
            completion(user)
        }
    }
}
