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
            TitleView().environmentObject(appState)
            
        }else if screenMode == .normalFirst || screenMode == .normalSecond{
            VStack{
                if screenMode == .normalFirst{
                    Text("Choose Your Hand")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                }else if screenMode == .normalSecond && judgeRPS(player: playerHand, cpu: cpuHand) == .win{
                    Text("WON!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.green)
                        .padding()
                }else if screenMode == .normalSecond && judgeRPS(player: playerHand, cpu: cpuHand) == .lose{
                    Text("LOSE")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.blue)
                        .padding()
                }else if screenMode == .normalSecond && judgeRPS(player: playerHand, cpu: cpuHand) == .draw{
                    Text("DRAW")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.gray)
                        .padding()
                }
                
                ZStack{
                    
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 200, height: 200)
                        .opacity(0.2)
                        .padding()
                    
                    if screenMode == .normalFirst{
                        
                    }else if screenMode == .normalSecond && cpuHand == .rock{
                        Image("rock")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .padding()
                        
                    }else if screenMode == .normalSecond && cpuHand == .paper{
                        Image("paper")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .padding()
                    }else if screenMode == .normalSecond && cpuHand == .scissors{
                        Image("scissors")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .padding()
                    }
                }
                
                
                HStack{
                    Button{
                        playerHand = .rock
                        screenMode = .normalSecond
                        cpuHand = RPSHand.allCases.randomElement()!
                    }label:{
                        Image("rock")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .padding()
                            .background(Color.pink)
                            .cornerRadius(10)
                    }
                    
                    Button{
                        playerHand = .paper
                        cpuHand = RPSHand.allCases.randomElement()!
                    } label:{
                        Image("paper")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Button{
                        playerHand = .scissors
                        cpuHand = RPSHand.allCases.randomElement()!
                    } label:{
                        Image("scissors")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .padding()
                            .background(Color.yellow)
                            .cornerRadius(10)
                    }
                }.padding(50)
                    
                    Button{
                        screenMode = .title
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
        }else if screenMode == .brainTraining{
            VStack{
                HStack{
                    Text("Time")
                        .font(.title)
                        .bold()
                    ZStack(alignment: .leading){
                        Rectangle()
                            .frame(width: 300, height: 15)
                            .foregroundColor(.gray)
                        Rectangle()
                            .frame(width: CGFloat((AppState.timeLimit-AppState.elapsedTime)/AppState.timeLimit)*300, height: 15)
                            .foregroundColor(.red)
                            .onReceive(timer) { _ in
                                AppState.elapsedTime += 0.01 //default 0.01
                                if AppState.elapsedTime >= AppState.timeLimit{
                                    screenMode = .finished
                                    AppState.elapsedTime = 0
                                }
                            }
                    }
                    .frame(width: 300)
                }
                
                Text("Score : " + String(AppState.score))
                    .font(.title)
                    .padding()
                

                Text(instruction.rawValue)
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
                            AppState.score += 1
                        }else {
                            playSound(named: "wrong")
                            AppState.score -= 1
                        }
                        cpuHand = RPSHand.allCases.randomElement()!
                        instruction = RPSResult.allCases.randomElement()!
                    }
                    
                    makeHandButton(hand: .paper, color: .blue){
                        playerHand = .paper
                        if instruction == judgeRPS(player: playerHand, cpu: cpuHand){
                            playSound(named: "correct")
                            AppState.score += 1
                        }else {
                            playSound(named: "wrong")
                            AppState.score -= 1
                        }
                        cpuHand = RPSHand.allCases.randomElement()!
                        instruction = RPSResult.allCases.randomElement()!
                    }
                    
                    makeHandButton(hand: .scissors, color: .yellow){
                        playerHand = .scissors
                        if instruction == judgeRPS(player: playerHand, cpu: cpuHand){
                            playSound(named: "correct")
                            AppState.score += 1
                        }else {
                            playSound(named: "wrong")
                            AppState.score -= 1
                        }
                        cpuHand = RPSHand.allCases.randomElement()!
                        instruction = RPSResult.allCases.randomElement()!
                    }
                    
                }.padding(50)
            }
            
        }else if screenMode == .finished{
            Text("Finished!")
                .font(.largeTitle)
                .bold()
                .padding()
                .onReceive(timer) { _ in
                    AppState.elapsedTime += 0.01 //default 0.01
                    if AppState.elapsedTime >= 2{
                        screenMode = .result
                        AppState.elapsedTime = 0
                    }
                }
            
        }else if screenMode == .result{
            VStack{
                Text("Result")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Text("Your Score : \(AppState.score)")
                    .font(.title)
                    .padding()
                if AppState.score > AppState.highScore{
                    Text("🎉 New High Score!")
                        .font(.title)
                        .bold()
                        .padding()
                }else {
                    Text("High Score : \(AppState.highScore)")
                        .font(.title)
                        .padding()
                }
                Spacer()
                
                Button{
                    screenMode = .brainTraining
                    if AppState.score > AppState.highScore{
                        AppState.highScore = AppState.score
                    }
                    AppState.elapsedTime = 0
                    AppState.score = 0
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
                    if AppState.score > AppState.highScore{
                        AppState.highScore = AppState.score
                    }
                    AppState.elapsedTime = 0
                    AppState.score = 0
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
    
    
    

    
    func makeHandButton(
        hand: RPSHand,
        color: Color,
        action: @escaping () -> Void
    ) -> some View{
        Button(action: action){
            Image(hand.rawValue)
                .resizable()
                .frame(width: 80, height: 80)
                .padding()
                .background(color)
                .cornerRadius(10)
            
        }
    }
    
}

#Preview {
    ContentView()
}
