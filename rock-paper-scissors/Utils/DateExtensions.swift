//
//  DateExtensions.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/05/28.
//

import Foundation


extension Date {
    var yyyymmddTag: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyyMMdd"
        return formatter.string(from: self)
    }
}
