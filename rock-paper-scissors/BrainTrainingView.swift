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
    @State private var showAnimation = false
    @State private var showLevelUp = false

    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

    
    var body: some View {
        ZStack{
            backgroundColor(for: appState.level)
                .ignoresSafeArea()
            
            VStack{
                HStack{
                    Text("time_label".localized)
                        .font(.title)
                        .bold()
                        .foregroundColor(Color("textWhite"))
                        .frame(width: 120)
                    ZStack(alignment: .leading){
                        Rectangle()
                            .frame(width: 250, height: 15)
                            .foregroundColor(.gray)
                        Rectangle()
                            .frame(width: CGFloat(appState.remainingTime/appState.timeLimit)*250, height: 15)
                            .foregroundColor(Color("timeBar"))
                            .onReceive(timer) { _ in
                                appState.elapsedTime += 0.01 //default 0.01
                                appState.remainingTime -= 0.01*(1 + Double(appState.level)*0.5)
                                if appState.remainingTime <= 0{
                                    
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
                                    //appState.updateChartData()
                                    
                                    playSound(named: "finished")
                                    screenMode = .finished
                                    appState.elapsedTime = 0
                                }
                            }
                    }
                    .frame(width: 250)
                }
                
                HStack{
                    Text("Level")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color("textWhite"))
                        .frame(width: 120)
                    ZStack(alignment: .leading){
                        Rectangle()
                            .frame(width: 250, height: 15)
                            .foregroundColor(.gray)
                        Rectangle()
                            .frame(width: CGFloat(Double(appState.score % appState.levelChangeValue)/Double(appState.levelChangeValue))*250, height: 15)
                            .foregroundColor(Color("levelBar"))
                    }
                    .frame(width: 250)
                }
                
                Text("score_label".localized + String(appState.score))
                    .font(.title)
                    .padding()
                    .foregroundColor(Color("textWhite"))
                Text(String(appState.inARowCount) + " in a row!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color("textWhite"))
                    .shadow(radius: 2)
                    .scaleEffect(showAnimation ? 1.2 : 1)
                    .animation(.spring(response: 0.3), value: showAnimation)
                    .padding()
                
                Text(instruction.localizedText)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color("textWhite"))
                
                
                Image(cpuHand.rawValue)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .padding()
                
                
                HStack{
                    makeHandButton(hand: .rock, color: backgroundColor(for: appState.level)){
                        playerHand = .rock
                        if instruction == judgeRPS(player: playerHand, cpu: cpuHand){
                            playSound(named: "correct")
                            appState.score += 1
                            appState.numberOfCorrectAnswers += 1
                            appState.inARowCount += 1
                            
                            //Combo time bonus
                            if (appState.inARowCount % 5 == 0) && (appState.inARowCount > 1) {
                                appState.remainingTime += appState.timeRecoveryValue
                                playSound(named: "recover")
                                //playSound(named: "clap")
                            }
                            
                            //Level Up
                            if (appState.score % appState.levelChangeValue == 0) && (appState.score > 1) {
                                appState.remainingTime = appState.timeLimit
                                appState.level += 1
                                playSound(named: "recover")
                                playSound(named: "levelUp")
                                showLevelUp = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                    showLevelUp = false
                                }
                            }
                            
                            //Animation
                            showAnimation = false
                            DispatchQueue.main.async{
                                showAnimation = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                showAnimation = false
                            }
                        }else {
                            playSound(named: "wrong")
                            appState.inARowCount = 0
                        }
                        cpuHand = RPSHand.allCases.randomElement()!
                        instruction = RPSResult.allCases.randomElement()!
                    }
                    
                    makeHandButton(hand: .paper, color: backgroundColor(for: appState.level)){
                        playerHand = .paper
                        if instruction == judgeRPS(player: playerHand, cpu: cpuHand){
                            playSound(named: "correct")
                            appState.numberOfCorrectAnswers += 1
                            appState.inARowCount += 1
                            appState.score += 1
                            //Combo time bonus
                            if (appState.inARowCount % 5 == 0) && (appState.inARowCount > 1) {
                                appState.remainingTime += appState.timeRecoveryValue
                                playSound(named: "recover")
                                //playSound(named: "clap")
                            }
                            //Level Up
                            if (appState.score % appState.levelChangeValue == 0) && (appState.score > 1) {
                                appState.remainingTime = appState.timeLimit
                                appState.level += 1
                                playSound(named: "recover")
                                playSound(named: "levelUp")
                                showLevelUp = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                    showLevelUp = false
                                }
                            }
                            showAnimation = false
                            DispatchQueue.main.async{
                                showAnimation = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                showAnimation = false
                            }
                        }else {
                            playSound(named: "wrong")
                            appState.inARowCount = 0
                        }
                        cpuHand = RPSHand.allCases.randomElement()!
                        instruction = RPSResult.allCases.randomElement()!
                    }
                    
                    makeHandButton(hand: .scissors, color: backgroundColor(for: appState.level)){
                        playerHand = .scissors
                        if instruction == judgeRPS(player: playerHand, cpu: cpuHand){
                            playSound(named: "correct")
                            appState.numberOfCorrectAnswers += 1
                            appState.score += 1
                            appState.inARowCount += 1
                            //Combo time bonus
                            if (appState.inARowCount % 5 == 0) && (appState.inARowCount > 1) {
                                appState.remainingTime += appState.timeRecoveryValue
                                playSound(named: "recover")
                                //playSound(named: "clap")
                            }
                            //Level Up
                            if (appState.score % appState.levelChangeValue == 0) && (appState.score > 1) {
                                appState.remainingTime = appState.timeLimit
                                appState.level += 1
                                playSound(named: "recover")
                                playSound(named: "levelUp")
                                showLevelUp = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                    showLevelUp = false
                                }
                            }
                            showAnimation = false
                            DispatchQueue.main.async{
                                showAnimation = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                showAnimation = false
                            }
                        }else {
                            playSound(named: "wrong")
                            appState.inARowCount = 0
                        }
                        cpuHand = RPSHand.allCases.randomElement()!
                        instruction = RPSResult.allCases.randomElement()!
                    }
                    
                }.padding(50)
            }
            
            //Level Up Animation
            if showLevelUp {
                VStack{
                    Text("Level Up!")
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundColor(.yellow)
                        .shadow(radius: 4)
                        .scaleEffect(showLevelUp ? 1.5 : 1.0)
                        .opacity(showLevelUp ? 1.0 : 0.0)
                        .transition(.opacity)
                        .animation(.easeOut(duration: 0.3), value: showLevelUp)
                    
                }
            }
        }
    }
}
