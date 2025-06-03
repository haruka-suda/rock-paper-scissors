//
//  ChartData.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/05/30.
//

import Foundation

struct DailyHighScore: Identifiable {
    let id = UUID()
    let date: Date
    let highScore: Int
}
