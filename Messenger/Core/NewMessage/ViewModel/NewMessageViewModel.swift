//
//  NewMessageViewModel.swift
//  Messenger
//
//  Created by Sebastian on 12/27/23.
//

import Firebase
import Foundation

class NewMessageViewModel: ObservableObject {
    @Published var users = [User]()

    init() {
        Task {
            try await fetchUsers()
        }
    }

    func fetchUsers() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else {
            print("DEBUG: unable to fetch the currentUid to fetchUsers")
            return
        }

        var users = try await UserServiceImpl.fetchAllUsers()

        // current user should NOT be in the list of contacts to message
        self.users = users.filter { user in
            user.id != currentUid
        }
    }
}
