//
//  RPSLogic.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/05/11.
//

import Foundation


//function for Judging RPS
func judgeRPS(player: RPSHand, cpu: RPSHand) -> RPSResult {
    if player == cpu {
        return .draw
    }else if (player == .rock && cpu == .scissors) || (player == .paper && cpu == .rock) || (player == .scissors && cpu == .paper){
        return .win
    }else {
        return .lose
    }
}
