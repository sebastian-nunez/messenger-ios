//
//  User.swift
//  Messenger
//
//  Created by Sebastian on 12/21/23.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    var id = NSUUID().uuidString

    let fullName: String
    let email: String
    var profileImageUrl: String?
}

extension User {
    static let MOCK_USER = User(fullName: "Bruce Wayne", email: "batman@gmail.com", profileImageUrl: "batman")
}
