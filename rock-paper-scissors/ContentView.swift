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
            FinishedView(screenMode: $screenMode).environmentObject(appState)
            
        }else if screenMode == .result{
            ResultView(instruction: $instruction, playerHand: $playerHand, cpuHand: $cpuHand, screenMode: $screenMode).environmentObject(appState)
        }
        
        
    }
    
    
    
    
    

    
}

#Preview("English") {
    ContentView()
        .environment(\.locale, .init(identifier: "en"))
}

#Preview("Japanese") {
    ContentView()
        .environment(\.locale, .init(identifier: "ja"))
}

#Preview("French") {
    ContentView()
        .environment(\.locale, .init(identifier: "fr"))
}
