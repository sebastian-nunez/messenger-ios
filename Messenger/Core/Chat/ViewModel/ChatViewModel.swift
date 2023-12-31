//
//  ChatViewModel.swift
//  Messenger
//
//  Created by Sebastian on 12/31/23.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var messageText = ""
    let user: User

    init(user: User) {
        self.user = user
    }

    func sendMessage() {
        print("DEBUG: attempting to send message to \(user.id)")

        MessageServiceImpl.shared.sendMessage(to: user, messageText)
    }
}
