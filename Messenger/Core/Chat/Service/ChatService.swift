//
//  ChatService.swift
//  Messenger
//
//  Created by Sebastian on 12/31/23.
//

import Foundation

protocol ChatService {
    var chatPartner: User { get }

    func sendMessage(_ messageText: String)
    func observeMessages(completion: @escaping ([Message]) -> Void)
}
