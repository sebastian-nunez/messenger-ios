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

    private let service: ChatService

    init(chatPartner: User) {
        service = ChatServiceImpl(chatPartner: chatPartner)
        observeMessages()
    }

    func sendMessage() {
        service.sendMessage(messageText)
    }

    func observeMessages() {
        service.observeMessages { messages in
            // add the new messages
            self.messages.append(contentsOf: messages)
        }
    }
}
