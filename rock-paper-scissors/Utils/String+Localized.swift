//
//  String+Localized.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/05/16.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
