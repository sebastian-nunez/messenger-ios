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
    let chatPartner: User

    init(chatPartner: User) {
        self.chatPartner = chatPartner
        observeMessages()
    }

    func sendMessage() {
        print("DEBUG: attempting to send message to \(chatPartner.id)")

        MessageServiceImpl.shared.sendMessage(to: chatPartner, messageText)
    }

    func observeMessages() {
        MessageServiceImpl.shared.observeMessages(chatPartner: chatPartner) { messages in
            // add the new messages
            self.messages.append(contentsOf: messages)
        }
    }
}
