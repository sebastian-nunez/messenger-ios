//
//  AuthService.swift
//  Messenger
//
//  Created by Sebastian on 12/22/23.
//

import Foundation

protocol AuthService {
    func login(withEmail email: String, password: String) async throws

    func createUser(withEmail email: String, password: String, fullname: String) async throws
}
