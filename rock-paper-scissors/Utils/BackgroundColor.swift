//
//  BackgroundColor.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/07/02.
//

import Foundation
import SwiftUI

func backgroundColor(for level: Int) -> Color {
    switch level {
        case 1: return Color("level1")
        case 2: return Color("level2")
        case 3: return Color("level3")
        case 4: return Color("level4")
        case 5: return Color("level5")
        default: return Color("level6+")
    }
}
