//
//  MessageService.swift
//  Messenger
//
//  Created by Sebastian on 12/31/23.
//

import Foundation

protocol MessageService {
    func sendMessage(to user: User, _ messageText: String)
}
