//
//  AuthServiceImpl.swift
//  Messenger
//
//  Created by Sebastian on 12/22/23.
//

import Firebase
import Foundation

class AuthServiceImpl: AuthService {
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("DEBUG: created user \(result.user.uid)")
        } catch {
            
        }
    }

    func login(withEmail email: String, password: String) async throws {
        print("DEBUG: logging in user with email \(email)")
    }
}
