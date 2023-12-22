//
//  AuthServiceImpl.swift
//  Messenger
//
//  Created by Sebastian on 12/22/23.
//

import Foundation

class AuthServiceImpl: AuthService {
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        print("DEBUG: creating user with email \(email)")
    }

    func login(withEmail email: String, password: String) async throws {
        print("DEBUG: logging in user with email \(email)")
    }
}
