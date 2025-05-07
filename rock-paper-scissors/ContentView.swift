//
//  ContentView.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/04/30.
//


import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer?
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    enum ScreenMode {
        case title
        case normalFirst
        case normalSecond
        case brainTraining
        case finished
        case result
    }
    
    enum RPSHand: CaseIterable {
        case rock
        case paper
        case scissors
    }
    
    enum RPSResult: CaseIterable {
        case win
        case lose
        case draw
    }
    
    
    @State var screenMode: ScreenMode = .title
    
    
    @State var playerHand: RPSHand = .rock
    @State var cpuHand: RPSHand = .rock
    @State var timeLimit = 60.0
    @State var elapsedTime = 0.0
    
   
    @State var instruction: RPSResult = .win
    @State var score = 0
    @State var highScore = 0
    
    var body: some View {
        
        if screenMode == .title{
            VStack{
                Text("RPS Challenge")
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
                        Text("Normal Mode")
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
                        score = 0
                        elapsedTime = 0
                        instruction = RPSResult.allCases.randomElement()!
                        cpuHand = RPSHand.allCases.randomElement()!
                    } label: {
                        Text("Brain Training")
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
        }else if screenMode == .normalFirst || screenMode == .normalSecond{
            VStack{
                if screenMode == .normalFirst{
                    Text("Choose Your Hand")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                }else if screenMode == .normalSecond && ((playerHand == .rock && cpuHand == .scissors)||(playerHand == .paper && cpuHand == .rock)||(playerHand == .scissors && cpuHand == .paper)){
                    Text("WON!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.green)
                        .padding()
                }else if screenMode == .normalSecond && ((playerHand == .rock && cpuHand == .paper)||(playerHand == .paper && cpuHand == .scissors)||(playerHand == .scissors && cpuHand == .rock)){
                                Text("LOSE")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(.blue)
                                    .padding()
                }else if screenMode == .normalSecond && playerHand == cpuHand{
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
                            .frame(width: CGFloat((timeLimit-elapsedTime)/timeLimit)*300, height: 15)
                            .foregroundColor(.red)
                            .onReceive(timer) { _ in
                                elapsedTime += 0.01 //default 0.01
                                if elapsedTime >= timeLimit{
                                    screenMode = .finished
                                    elapsedTime = 0
                                }
                            }
                    }
                    .frame(width: 300)
                }
                
                Text("Score : " + String(score))
                    .font(.title)
                    .padding()
                
                if instruction == .win{
                    Text("Win")
                        .font(.largeTitle)
                        .bold()
                }else if instruction == .lose{
                    Text("Lose")
                        .font(.largeTitle)
                        .bold()
                }else if instruction == .draw{
                    Text("Draw")
                        .font(.largeTitle)
                        .bold()
                }
                
                if cpuHand == .rock{
                    Image("rock")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .padding()
                    
                }else if cpuHand == .paper{
                    Image("paper")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .padding()
                }else if cpuHand == .scissors{
                    Image("scissors")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .padding()
                }
                
                HStack{
                    Button{
                        playerHand = .rock
                        if instruction == judgeRPS(player: playerHand, cpu: cpuHand){
                            playSound(named: "correct")
                            score += 1
                        }else {
                            playSound(named: "wrong")
                            score -= 1
                        }
                        cpuHand = RPSHand.allCases.randomElement()!
                        instruction = RPSResult.allCases.randomElement()!
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
                        if instruction == judgeRPS(player: playerHand, cpu: cpuHand){
                            playSound(named: "correct")
                            score += 1
                        }else {
                            playSound(named: "wrong")
                            score -= 1
                        }
                        cpuHand = RPSHand.allCases.randomElement()!
                        instruction = RPSResult.allCases.randomElement()!
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
                        if instruction == judgeRPS(player: playerHand, cpu: cpuHand){
                            playSound(named: "correct")
                            score += 1
                        }else {
                            playSound(named: "wrong")
                            score -= 1
                        }
                        cpuHand = RPSHand.allCases.randomElement()!
                        instruction = RPSResult.allCases.randomElement()!
                    } label:{
                        Image("scissors")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .padding()
                            .background(Color.yellow)
                            .cornerRadius(10)
                    }
                }.padding(50)
            }
            
        }else if screenMode == .finished{
            Text("Finished!")
                .font(.largeTitle)
                .bold()
                .padding()
                .onReceive(timer) { _ in
                    elapsedTime += 0.01 //default 0.01
                    if elapsedTime >= 2{
                        screenMode = .result
                        elapsedTime = 0
                    }
                }
            
        }else if screenMode == .result{
            VStack{
                Text("Result")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Text("Your Score : \(score)")
                    .font(.title)
                    .padding()
                if score > highScore{
                    Text("🎉 New High Score!")
                        .font(.title)
                        .bold()
                        .padding()
                }else {
                    Text("High Score : \(highScore)")
                        .font(.title)
                        .padding()
                }
                Spacer()
                
                Button{
                    screenMode = .brainTraining
                    if score > highScore{
                        highScore = score
                    }
                    elapsedTime = 0
                    score = 0
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
                    if score > highScore{
                        highScore = score
                    }
                    elapsedTime = 0
                    score = 0
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
    

    //function for Judging RPS
    func judgeRPS(player: RPSHand, cpu: RPSHand) -> RPSResult {
        if player == cpu {
            return .draw
        }else if (player == .rock && cpu == .scissors) || (player == .paper && cpu == .rock) || (player == .scissors && cpu == .paper){
            return .win
        }else {
            return .lose
        }
    }
    
    
    func playSound(named soundName: String){
        if let soundURL = Bundle.main.url(forResource: soundName, withExtension: "mp3"){
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Sound error: \(error.localizedDescription)")
            }
        }
    }
    
}

#Preview {
    ContentView()
}
