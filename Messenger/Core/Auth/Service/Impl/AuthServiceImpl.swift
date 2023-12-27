//
//  AuthServiceImpl.swift
//  Messenger
//
//  Created by Sebastian on 12/22/23.
//

import Firebase
import Foundation

class AuthServiceImpl: AuthService {
    @Published var userSession: FirebaseAuth.User?

    init() {
        self.userSession = Auth.auth().currentUser
        print("DEBUG: user session id \(userSession?.uid ?? "NO SESSION")")
    }

    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("DEBUG: created user \(result.user.uid)")
        } catch {
            print("DEBUG: unable to create user with email \(email) and error: \(error.localizedDescription)")
        }
    }

    func login(withEmail email: String, password: String) async throws {
        if let user = userSession {
            print("DEBUG: user is already logged in with email \(user.email ?? "NO EMAIL")")
            return
        }

        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            print("DEBUG: signed in user \(result.user.uid)")
        } catch {
            print("DEBUG: unable to login user with email \(email) and error: \(error.localizedDescription)")
        }
    }
}
