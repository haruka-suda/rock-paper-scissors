//
//  convertToChartData.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/06/03.
//

import Foundation

func convertToChartData(from history: [String: Int]) -> [DailyHighScore]{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMdd"
    formatter.locale = Locale(identifier: "en_US_POSIX")
    
    var result: [DailyHighScore] = []
    
    for (key, value) in history {
        if let date = formatter.date(from: key){
            result.append(DailyHighScore(date: date, highScore: value))
        }
    }
    return result.sorted { $0.date < $1.date }
}

