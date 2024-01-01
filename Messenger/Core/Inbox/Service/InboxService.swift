//
//  InboxService.swift
//  Messenger
//
//  Created by Sebastian on 1/1/24.
//

import Firebase
import Foundation

protocol InboxService {
    var documentChanges: [DocumentChange] { get } // @Published

    func observeRecentMessages()
}
