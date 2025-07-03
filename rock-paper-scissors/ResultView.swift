//
//  ResultView.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/05/15.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var appState: AppState
    @Binding var instruction: RPSResult
    @Binding var playerHand: RPSHand
    @Binding var cpuHand: RPSHand
    @Binding var screenMode: ScreenMode
    
    var body: some View {
        ZStack{
            Color("primaryBlue")
                .ignoresSafeArea()
            VStack{
                Text("result_label".localized)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                Text("your_score_label".localized + "\(appState.score)")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                Text("Average Reaction Time : " + String(format: "%.2f ms",appState.timeLimit / Double(appState.numberOfCorrectAnswers) * 1000))
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                
                
                
                //            
                //            if appState.score > appState.highScore{
                //                Text("notification_high_score".localized)
                //                    .font(.title)
                //                    .bold()
                //                    .padding()
                //            }else {
                //                Text("high_score_label".localized + "\(appState.highScore)")
                //                    .font(.title)
                //                    .padding()
                //            }
                Spacer()
                
                Button{
                    screenMode = .brainTraining
                    if appState.score > appState.highScore{
                        appState.highScore = appState.score
                        UserDefaults.standard.set(appState.highScore, forKey: "highScore")
                    }
                    appState.elapsedTime = 0
                    appState.remainingTime = appState.timeLimit
                    appState.score = 0
                    cpuHand = RPSHand.allCases.randomElement()!
                    instruction = RPSResult.allCases.randomElement()!
                } label: {
                    Text("play_again_label".localized)
                        .font(.title)
                        .bold()
                        .padding()
                        .frame(maxWidth: 350)
                        .background(Color.white)
                        .foregroundColor(Color("primaryBlue"))
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.8), radius: 1, x:0, y:8)
                }
                .padding()
                
                Button{
                    appState.isInGame = false
                    if appState.score > appState.highScore{
                        appState.highScore = appState.score
                        UserDefaults.standard.set(appState.highScore, forKey: "highScore")
                        
                    }
                    appState.elapsedTime = 0
                    appState.score = 0
                    playerHand = .rock
                    cpuHand = .rock
                } label: {
                    Text("return_to_the_title".localized)
                        .font(.title)
                        .bold()
                        .padding()
                        .frame(maxWidth: 350)
                        .background(Color("primaryBlue"))
                        .foregroundColor(.white)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 4))
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.8), radius: 1, x:0, y:8)
                }
                
            }
        }
    }
}


