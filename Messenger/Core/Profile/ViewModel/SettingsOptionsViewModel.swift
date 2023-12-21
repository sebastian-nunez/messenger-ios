//
//  SettingsOptionsViewModel.swift
//  Messenger
//
//  Created by Sebastian on 12/21/23.
//

import Foundation
import SwiftUI

enum SettingsOptionsViewModel: Int, Identifiable, CaseIterable {
    case darkMode
    case activeStatus
    case accessibility
    case privacy
    case notifications

    var id: Int {
        self.rawValue
    }

    var title: String {
        switch self {
        case .darkMode: "Dark Mode"
        case .activeStatus: "Active Status"
        case .accessibility: "Accessibility"
        case .privacy: "Privacy and Safety"
        case .notifications: "Notifications"
        }
    }

    var imageBackgroundColor: Color {
        switch self {
        case .darkMode: .black
        case .activeStatus: Color(.systemGreen)
        case .accessibility: .black
        case .privacy: Color(.systemBlue)
        case .notifications: Color(.systemPurple)
        }
    }

    var imageName: String {
        switch self {
        case .darkMode: "moon.circle.fill"
        case .activeStatus: "message.badge.circle.fill"
        case .accessibility: "person.circle.fill"
        case .privacy: "lock.circle.fill"
        case .notifications: "bell.circle.fill"
        }
    }
}
