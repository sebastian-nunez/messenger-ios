//
//  InboxViewModel.swift
//  Messenger
//
//  Created by Sebastian on 12/27/23.
//

import Combine
import Firebase
import Foundation

class InboxViewModel: ObservableObject {
    @Published var currentUser: User?

    private var cancellables = Set<AnyCancellable>()

    init() {
        setupSubscribers()
    }

    private func setupSubscribers() {
        UserServiceImpl.shared.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }
        .store(in: &cancellables)
    }
}
