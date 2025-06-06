//
//  AppState.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/05/11.
//

import Foundation
import SwiftUI


class AppState: ObservableObject {
    @Published var timeLimit = 5.0
    @Published var elapsedTime = 0.0
    @Published var score = 0
    @Published var highScore = 0
    @Published var highScoreHistory: [String: Int] = [:]
    @Published var chartData: [DailyHighScore] = []
    
    init() {
        self.highScore = UserDefaults.standard.integer(forKey: "highScore")
        
        if let saved = UserDefaults.standard.dictionary(forKey: "highScoreHistory") as? [String: Int] {
            self.highScoreHistory = saved
        }
    }
    
    func updateChartData(){
        self.chartData = convertToChartData(from: self.highScoreHistory)
    }
}


