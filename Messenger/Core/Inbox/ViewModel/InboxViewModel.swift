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
    @Published var recentMessages = [Message]()

    private let service = InboxServiceImpl()
    private var cancellables = Set<AnyCancellable>()

    init() {
        service.observeRecentMessages()
        setupSubscribers()
    }

    private func setupSubscribers() {
        // retrieve the current user's data
        UserServiceImpl.shared.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }
        .store(in: &cancellables)

        // fetch recent messages
        service.$documentChanges.sink { [weak self] documentChanges in
            self?.loadInitialRecentMessages(from: documentChanges)
        }
        .store(in: &cancellables)
    }

    private func loadInitialRecentMessages(from changes: [DocumentChange]) {
        let messages = changes.compactMap { change in
            try? change.document.data(as: Message.self)
        }

        for i in 0 ..< messages.count {
            var message = messages[i]

            // attach the user/chat-partner OBJECT for the message (profile picture + other metadata)
            UserServiceImpl.fetchUser(with: message.chatPartnerId) { user in
                message.user = user
                self.recentMessages.append(message)
            }
        }
    }
}
