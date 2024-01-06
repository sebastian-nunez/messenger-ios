//
//  Date.swift
//  Messenger
//
//  Created by Sebastian on 1/6/24.
//

import Foundation
import SwiftUI

extension Date {
    /// Format a time as follows -> HH:mm (ex. 02:34)
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        return formatter
    }

    /// Format a time as follows -> MM/dd/yyyy (ex. 01/23/23)
    private var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateFormat = "MM/dd/yy"
        return formatter
    }

    /// Returns a descriptive timestamp respresentation. ex. "10:32" for the case of today, "Yesterday", or "11/13/23" for other dates.
    func timestampString() -> String {
        if Calendar.current.isDateInToday(self) { // current day
            return timeString()
        } else if Calendar.current.isDateInYesterday(self) {
            return "Yesterday"
        } else {
            return dateString()
        }
    }

    /// Returns the String respresentation of the current time formatted using the "timeFormatter"
    private func timeString() -> String {
        return timeFormatter.string(from: self)
    }

    /// Returns the String respresentation of the current date formatted using the "dayFormatter"
    private func dateString() -> String {
        return dayFormatter.string(from: self)
    }
}
