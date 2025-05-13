//
//  ContentView.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/04/30.
//


import SwiftUI
import AVFoundation

struct ContentView: View {
    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    @State var screenMode: ScreenMode = .title
    @State var playerHand: RPSHand = .rock
    @State var cpuHand: RPSHand = .rock
    @State var instruction: RPSResult = .win
    
    @StateObject var appState = AppState()

    
    var body: some View {
        
        if screenMode == .title{
            TitleView(instruction: $instruction, cpuHand: $cpuHand, screenMode: $screenMode).environmentObject(appState)
            
        }else if screenMode == .normalFirst || screenMode == .normalSecond{
            NormalModeView(instruction: $instruction, playerHand: $playerHand, cpuHand: $cpuHand, screenMode: $screenMode).environmentObject(appState)
            
        }else if screenMode == .brainTraining{
            BrainTrainingView(instruction: $instruction, playerHand: $playerHand, cpuHand: $cpuHand, screenMode: $screenMode).environmentObject(appState)
            
        }else if screenMode == .finished{
            Text("Finished!")
                .font(.largeTitle)
                .bold()
                .padding()
                .onReceive(timer) { _ in
                    appState.elapsedTime += 0.01 //default 0.01
                    if appState.elapsedTime >= 2{
                        screenMode = .result
                        appState.elapsedTime = 0
                    }
                }
            
        }else if screenMode == .result{
            VStack{
                Text("Result")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Text("Your Score : \(appState.score)")
                    .font(.title)
                    .padding()
                if appState.score > appState.highScore{
                    Text("🎉 New High Score!")
                        .font(.title)
                        .bold()
                        .padding()
                }else {
                    Text("High Score : \(appState.highScore)")
                        .font(.title)
                        .padding()
                }
                Spacer()
                
                Button{
                    screenMode = .brainTraining
                    if appState.score > appState.highScore{
                        appState.highScore = appState.score
                    }
                    appState.elapsedTime = 0
                    appState.score = 0
                    cpuHand = RPSHand.allCases.randomElement()!
                    instruction = RPSResult.allCases.randomElement()!
                } label: {
                    Text("Play Again")
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
                    }
                    appState.elapsedTime = 0
                    appState.score = 0
                    playerHand = .rock
                    cpuHand = .rock
                } label: {
                    Text("Return to the Title")
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
    
    
    
    
    

    
}

#Preview {
    ContentView()
}
