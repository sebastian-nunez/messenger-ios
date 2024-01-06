//
//  Route.swift
//  Messenger
//
//  Created by Sebastian on 1/6/24.
//

import Foundation

enum Route: Hashable {
    case profile(User)
    case chatView(User)
}
