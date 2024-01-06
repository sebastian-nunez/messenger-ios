//
//  ActiveNowViewModel.swift
//  Messenger
//
//  Created by Sebastian on 1/6/24.
//

import Firebase
import Foundation

class ActiveNowViewModel: ObservableObject {
    @Published var users = [User]()

    init() {
        Task {
            try await self.fetchUsers()
        }
    }

    @MainActor
    private func fetchUsers() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else {
            print("DEBUG: no user is logged in. Unable to fetch active now!")
            return
        }

        let unfilteredUsers = try await UserServiceImpl.fetchAllUsers(limit: 10)

        self.users = unfilteredUsers.filter { $0.id != currentUid } // skip the currently logged in user
    }
}
