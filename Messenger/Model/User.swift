//
//  User.swift
//  Messenger
//
//  Created by Sebastian on 12/21/23.
//

import FirebaseFirestoreSwift
import Foundation

struct User: Identifiable, Codable, Hashable {
    // Firestore ID
    @DocumentID var uid: String?

    let fullName: String
    let email: String
    var profileImageUrl: String?

    var id: String {
        return uid ?? NSUUID().uuidString
    }
}

extension User {
    static let MOCK_USER = User(fullName: "Bruce Wayne", email: "batman@gmail.com", profileImageUrl: "batman")
}
