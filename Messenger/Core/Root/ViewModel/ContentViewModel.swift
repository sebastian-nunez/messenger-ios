//
//  ContentViewModel.swift
//  Messenger
//
//  Created by Sebastian on 12/27/23.
//

import Combine
import Firebase
import Foundation

class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?

    private var cancellables = Set<AnyCancellable>()

    init() {
        setupSubscribers()
    }

    private func setupSubscribers() {
        AuthServiceImpl().$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }
        .store(in: &cancellables)
    }
}
