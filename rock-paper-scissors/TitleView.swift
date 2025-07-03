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
        ZStack{
            Color("primaryBlue")
                .ignoresSafeArea()
        VStack{
            Text("menu_title".localized)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.white)
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
                    //                Button{
                    //                    screenMode = .normalFirst
                    //                } label: {
                    //                    Text("normal_mode_button".localized)
                    //                        .font(.title)
                    //                        .bold()
                    //                        .padding()
                    //                        .frame(maxWidth: .infinity)
                    //                        .background(Color.blue)
                    //                        .foregroundColor(.white)
                    //                        .cornerRadius(10)
                    //                }
                    
                    Button{
                        appState.isInGame = true
                        screenMode = .brainTraining
                        appState.numberOfCorrectAnswers = 0
                        appState.score = 0
                        appState.elapsedTime = 0
                        appState.remainingTime = appState.timeLimit
                        instruction = RPSResult.allCases.randomElement()!
                        cpuHand = RPSHand.allCases.randomElement()!
                    } label: {
                        Text("brain_training_button".localized)
                            .font(.title)
                            .bold()
                            .padding()
                            .frame(maxWidth: 350)
                            .background(Color.white)
                            .foregroundColor(Color("primaryBlue"))
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.8), radius: 1, x:0, y:8)
                    }
                    //                Button{
                    //                    screenMode = .calendar
                    //                } label: {
                    //                    Text("calendar")
                    //                        .font(.title)
                    //                        .bold()
                    //                        .padding()
                    //                        .frame(maxWidth: .infinity)
                    //                        .background(Color.blue)
                    //                        .foregroundColor(.white)
                    //                        .cornerRadius(10)
                    //                }
                    //                Button{
                    //                    appState.updateChartData()
                    //                    screenMode = .lineGraph
                    //                } label: {
                    //                    Text("line graph")
                    //                        .font(.title)
                    //                        .bold()
                    //                        .padding()
                    //                        .frame(maxWidth: .infinity)
                    //                        .background(Color.blue)
                    //                        .foregroundColor(.white)
                    //                        .cornerRadius(10)
                    //                }
                    //                Button{
                    //                    screenMode = .debug
                    //                } label: {
                    //                    Text("Debug Mode")
                    //                        .font(.title)
                    //                        .bold()
                    //                        .padding()
                    //                        .frame(maxWidth: .infinity)
                    //                        .background(Color.blue)
                    //                        .foregroundColor(.white)
                    //                        .cornerRadius(10)
                    //                }
                }
            }
        }
    }
}
