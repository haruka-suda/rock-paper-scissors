//
//  RPSDefinitions.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/05/11.
//

import Foundation

enum RPSHand: String,CaseIterable {
    case rock
    case paper
    case scissors
}

enum RPSResult: String,CaseIterable{
    case win
    case lose
    case draw
}

extension RPSResult{
    var localizedText: String {
        switch self {
        case .win: return "instruction_win".localized
        case .lose: return "instruction_lose".localized
        case .draw: return "instruction_draw".localized
        }
    }
}
