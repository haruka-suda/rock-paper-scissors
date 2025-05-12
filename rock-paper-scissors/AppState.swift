//
//  AppState.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/05/11.
//

import Foundation
import SwiftUI


class AppState: ObservableObject {
    @Published var timeLimit = 60.0
    @Published var elapsedTime = 0.0
    @Published var score = 0
    @Published var highScore = 0
}
