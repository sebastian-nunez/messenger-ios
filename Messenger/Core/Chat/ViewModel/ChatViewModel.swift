//
//  ChatViewModel.swift
//  Messenger
//
//  Created by Sebastian on 12/31/23.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messageText = ""
    @Published var messages = [Message]()
    let user: User

    init(user: User) {
        self.user = user
        observeMessages()
    }

    func sendMessage() {
        print("DEBUG: attempting to send message to \(user.id)")

        MessageServiceImpl.shared.sendMessage(to: user, messageText)
    }

    func observeMessages() {
        MessageServiceImpl.shared.observeMessages(chatPartner: user) { messages in
            // add the new messages
            self.messages.append(contentsOf: messages)
        }
    }
}
