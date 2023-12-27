//
//  AuthServiceImpl.swift
//  Messenger
//
//  Created by Sebastian on 12/22/23.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

class AuthServiceImpl: AuthService {
    static let shared = AuthServiceImpl()

    @Published var userSession: FirebaseAuth.User?

    init() {
        self.userSession = Auth.auth().currentUser
        print("DEBUG: user session id \(userSession?.uid ?? "NO SESSION")")

        fetchCurrentUserMetadata()
    }

    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            // create user within Firebase
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            userSession = result.user

            // save user metadata
            try await uploadUserMetadata(uid: result.user.uid, email: email, fullname: fullname)

            print("DEBUG: created user \(result.user.uid)")
        } catch {
            print("DEBUG: unable to create user with email \(email) and error: \(error.localizedDescription)")
        }

        fetchCurrentUserMetadata()
    }

    @MainActor
    func login(withEmail email: String, password: String) async throws {
        if let user = userSession {
            print("DEBUG: user is already logged in with email \(user.email ?? "NO EMAIL")")
            return
        }

        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            userSession = result.user // set the current session
            print("DEBUG: signed in user \(result.user.uid)")
        } catch {
            print("DEBUG: unable to login user with email \(email) and error: \(error.localizedDescription)")
        }

        fetchCurrentUserMetadata()
    }

    func logout() {
        // ensure we have a session before loggin out
        if userSession == nil {
            print("DEBUG: unable to logout without a userSession")
            return
        }

        do {
            try Auth.auth().signOut()
            userSession = nil
            UserServiceImpl.shared.currentUser = nil
            print("DEBUG: logged out user")
        } catch {
            print("DEBUG: unable to log out user with email \(userSession?.email ?? "NO EMAIL") with error \(error.localizedDescription)")
        }
    }

    /// Uploads a user's metadata to Firestore.
    private func uploadUserMetadata(uid: String, email: String, fullname: String) async throws {
        // create the user object
        let user = User(fullName: fullname, email: email, profileImageUrl: nil)

        // encode the user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else {
            print("DEBUG: unable to encode user with email \(email)")
            return
        }

        // save the user to Firestore
        try await Firestore.firestore().collection("users").document(uid).setData(encodedUser)
        print("DEBUG: saved user metadata with email \(email)")
    }

    /// Fetch the metadata for the logged in user via a "Task".
    private func fetchCurrentUserMetadata() {
        Task {
            try await UserServiceImpl.shared.fetchCurrentUser()
        }
    }
}
