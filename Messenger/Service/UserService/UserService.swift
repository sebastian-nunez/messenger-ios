//
//  UserService.swift
//  Messenger
//
//  Created by Sebastian on 12/27/23.
//

import Foundation

protocol UserService {
    var currentUser: User? { get set }

    func fetchCurrentUser() async throws
    static func fetchAllUsers(limit: Int?) async throws -> [User]
    static func fetchUser(with uid: String, completion: @escaping (User) -> Void)
}
