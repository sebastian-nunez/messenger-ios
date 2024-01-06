//
//  ActiveNowViewModel.swift
//  Messenger
//
//  Created by Sebastian on 1/6/24.
//

import Foundation

class ActiveNowViewModel: ObservableObject {
    @Published var users = [User]()

    init() {
        Task {
            try await self.fetchUsers()
        }
    }

    private func fetchUsers() async throws {
        self.users = try await UserServiceImpl.fetchAllUsers(limit: 10)
    }
}
