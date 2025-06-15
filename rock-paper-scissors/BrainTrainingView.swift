//
//  BrainTrainingView.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/05/13.
//

import SwiftUI

struct BrainTrainingView: View {
    @EnvironmentObject var appState: AppState
    @Binding var instruction: RPSResult
    @Binding var playerHand: RPSHand
    @Binding var cpuHand: RPSHand
    @Binding var screenMode: ScreenMode

    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

    
    var body: some View {
        VStack{
            HStack{
                Text("time_label".localized)
                    .font(.title)
                    .bold()
                ZStack(alignment: .leading){
                    Rectangle()
                        .frame(width: 300, height: 15)
                        .foregroundColor(.gray)
                    Rectangle()
                        .frame(width: CGFloat((appState.timeLimit-appState.elapsedTime)/appState.timeLimit)*300, height: 15)
                        .foregroundColor(.red)
                        .onReceive(timer) { _ in
                            appState.elapsedTime += 0.01 //default 0.01
                            if appState.elapsedTime >= appState.timeLimit{
                                
                                // record today's highscore
                                if appState.highScoreHistory[Date().yyyymmddTag] == nil {
                                    appState.highScoreHistory[Date().yyyymmddTag] = appState.score
                                }
                                if let todaysHighScore = appState.highScoreHistory[Date().yyyymmddTag]{
                                    if appState.score > todaysHighScore{
                                        appState.highScoreHistory[Date().yyyymmddTag] = appState.score
                                    }
                                }
                                
                                // save high score
                                UserDefaults.standard.set(appState.highScoreHistory, forKey: "highScoreHistory")
                                
                                screenMode = .finished
                                appState.elapsedTime = 0
                            }
                        }
                }
                .frame(width: 300)
            }
            
            Text("score_label".localized + String(appState.score))
                .font(.title)
                .padding()
            
            
            Text(instruction.localizedText)
                .font(.largeTitle)
                .bold()
            
            
            Image(cpuHand.rawValue)
                .resizable()
                .frame(width: 200, height: 200)
                .padding()
            
            
            HStack{
                makeHandButton(hand: .rock, color: .pink){
                    playerHand = .rock
                    if instruction == judgeRPS(player: playerHand, cpu: cpuHand){
                        playSound(named: "correct")
                        appState.score += 1
                    }else {
                        playSound(named: "wrong")
                        appState.score -= 1
                    }
                    cpuHand = RPSHand.allCases.randomElement()!
                    instruction = RPSResult.allCases.randomElement()!
                }
                
                makeHandButton(hand: .paper, color: .blue){
                    playerHand = .paper
                    if instruction == judgeRPS(player: playerHand, cpu: cpuHand){
                        playSound(named: "correct")
                        appState.score += 1
                    }else {
                        playSound(named: "wrong")
                        appState.score -= 1
                    }
                    cpuHand = RPSHand.allCases.randomElement()!
                    instruction = RPSResult.allCases.randomElement()!
                }
                
                makeHandButton(hand: .scissors, color: .yellow){
                    playerHand = .scissors
                    if instruction == judgeRPS(player: playerHand, cpu: cpuHand){
                        playSound(named: "correct")
                        appState.score += 1
                    }else {
                        playSound(named: "wrong")
                        appState.score -= 1
                    }
                    cpuHand = RPSHand.allCases.randomElement()!
                    instruction = RPSResult.allCases.randomElement()!
                }
                
            }.padding(50)
        }
    }
}
