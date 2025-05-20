//
//  TitleView.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/05/10.
//

import SwiftUI

struct TitleView: View {
    @EnvironmentObject var appState: AppState
    @Binding var instruction: RPSResult
    @Binding var cpuHand: RPSHand
    @Binding var screenMode: ScreenMode
    
    var body: some View {
        VStack{
            Text("menu_title".localized)
                .font(.largeTitle)
                .bold()
            Image("rock")
                .resizable()
                .frame(width: 150, height: 150)
                .padding()
            HStack{
                Image("paper")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding()
                Image("scissors")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding()
            }
            .padding()
            
            VStack{
                Button{
                    screenMode = .normalFirst
                } label: {
                    Text("normal_mode_button".localized)
                        .font(.title)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button{
                    screenMode = .brainTraining
                    appState.score = 0
                    appState.elapsedTime = 0
                    instruction = RPSResult.allCases.randomElement()!
                    cpuHand = RPSHand.allCases.randomElement()!
                } label: {
                    Text("brain_training_button".localized)
                        .font(.title)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}
