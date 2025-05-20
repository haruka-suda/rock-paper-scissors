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
        VStack{
            Text("result_label".localized)
                .font(.largeTitle)
                .bold()
                .padding()
            Text("your_score_label".localized + "\(appState.score)")
                .font(.title)
                .padding()
            if appState.score > appState.highScore{
                Text("notification_high_score".localized)
                    .font(.title)
                    .bold()
                    .padding()
            }else {
                Text("high_score_label".localized + "\(appState.highScore)")
                    .font(.title)
                    .padding()
            }
            Spacer()
            
            Button{
                screenMode = .brainTraining
                if appState.score > appState.highScore{
                    appState.highScore = appState.score
                    UserDefaults.standard.set(appState.highScore, forKey: "highScore")
                }
                appState.elapsedTime = 0
                appState.score = 0
                cpuHand = RPSHand.allCases.randomElement()!
                instruction = RPSResult.allCases.randomElement()!
            } label: {
                Text("play_again_label".localized)
                    .font(.title)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button{
                screenMode = .title
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
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
        }
    }
}


