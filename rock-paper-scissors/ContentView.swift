//
//  ContentView.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/04/30.
//


import SwiftUI
import AVFoundation

struct ContentView: View {
    // set color for unselected tab
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "tabUnselected")
    }
    
    
    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State private var selectedTab: ScreenMode = .title
    @State var screenMode: ScreenMode = .title
    @State var playerHand: RPSHand = .rock
    @State var cpuHand: RPSHand = .rock
    @State var instruction: RPSResult = .win
    
    @StateObject var appState = AppState()
    
    
    var body: some View {
        //don't display Tabs during the game
        if appState.isInGame {
            if screenMode == .brainTraining {
                BrainTrainingView(instruction: $instruction, playerHand: $playerHand, cpuHand: $cpuHand, screenMode: $screenMode).environmentObject(appState)
            }else if screenMode == .finished {
                FinishedView(screenMode: $screenMode).environmentObject(appState)
            }else if screenMode == .result {
                ResultView(instruction: $instruction, playerHand: $playerHand, cpuHand: $cpuHand, screenMode: $screenMode).environmentObject(appState)
            }
        }else {
            TabView(selection: $selectedTab){
                TitleView(instruction: $instruction, cpuHand: $cpuHand, screenMode: $screenMode)
                    .environmentObject(appState)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(ScreenMode.title)
                
                CalendarView()
                    .environmentObject(appState)
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("Calendar")
                    }
                    .tag(ScreenMode.calendar)
                
                LineGraphView(screenMode: $screenMode)
                    .environmentObject(appState)
                    .tabItem {
                        Image(systemName: "chart.xyaxis.line")
                        Text("Graph")
                    }
                    .tag(ScreenMode.lineGraph)
                
                DebugModeView(screenMode: $screenMode)
                    .environmentObject(appState)
                    .tabItem {
                        Image(systemName: "desktopcomputer")
                        Text("Debug")
                    }
                    .tag(ScreenMode.debug)
            }
            .accentColor(Color("tabAccent"))
        }
    }
}
        
        
//        if screenMode == .title{
//            TitleView(instruction: $instruction, cpuHand: $cpuHand, screenMode: $screenMode).environmentObject(appState)
//            
//        }else if screenMode == .normalFirst || screenMode == .normalSecond{
//            NormalModeView(instruction: $instruction, playerHand: $playerHand, cpuHand: $cpuHand, screenMode: $screenMode).environmentObject(appState)
//            
//        }else if screenMode == .brainTraining{
//            BrainTrainingView(instruction: $instruction, playerHand: $playerHand, cpuHand: $cpuHand, screenMode: $screenMode).environmentObject(appState)
//            
//        }else if screenMode == .finished{
//            FinishedView(screenMode: $screenMode).environmentObject(appState)
//            
//        }else if screenMode == .result{
//            ResultView(instruction: $instruction, playerHand: $playerHand, cpuHand: $cpuHand, screenMode: $screenMode).environmentObject(appState)
//        }else if screenMode == .calendar{
//            CalendarView()
//        }else if screenMode == .lineGraph{
//            LineGraphView(screenMode: $screenMode).environmentObject(appState)
//        }else if screenMode == .debug{
//            DebugModeView(screenMode: $screenMode).environmentObject(appState)
//        }
        
        

    
    
    
    

    

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
