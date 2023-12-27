//
//  AuthService.swift
//  Messenger
//
//  Created by Sebastian on 12/22/23.
//

import Firebase
import Foundation

protocol AuthService {
    var userSession: Firebase.User? { get }

    func login(withEmail email: String, password: String) async throws

    func createUser(withEmail email: String, password: String, fullname: String) async throws
}
