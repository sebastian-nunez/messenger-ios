//
//  UserService.swift
//  Messenger
//
//  Created by Sebastian on 12/27/23.
//

import Foundation

protocol UserService {
    var currentUser: User?

    func fetchCurrentUser() async throws
}
