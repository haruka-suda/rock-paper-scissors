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
    
    @State var screenMode = "title"
    
    //hands 0:initialized, 1:rock, 2:paper, 3:scissors
    @State var playerHand = 0
    @State var cpuHand = 0
    @State var timeLimit = 30.0
    @State var elapsedTime = 0.0
    
    // instruction 0:initialized, 1:win, 2:lose, 3:draw
    @State var instruction = 0
    @State var score = 0
    @State var highScore = 0
    
    var body: some View {
        
        if screenMode == "title"{
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
                        screenMode = "normalMode"
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
                        screenMode = "brainTraining"
                        score = 0
                        elapsedTime = 0
                        instruction = Int.random(in: 1...3)
                        cpuHand = Int.random(in: 1...3)
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
        }else if screenMode == "normalMode"{
            VStack{
                if cpuHand == 0{
                    Text("Choose Your Hand")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                }else if (playerHand == 1 && cpuHand == 3)||(playerHand == 2 && cpuHand == 1)||(playerHand == 3 && cpuHand == 2){
                    Text("WON!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.green)
                        .padding()
                }else if (playerHand == 1 && cpuHand == 2)||(playerHand == 2 && cpuHand == 3)||(playerHand == 3 && cpuHand == 1){
                                Text("LOSE")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(.blue)
                                    .padding()
                }else if playerHand == cpuHand{
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
                    
                    if cpuHand == 0{
                        
                    }else if cpuHand == 1{
                        Image("rock")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .padding()
                        
                    }else if cpuHand == 2{
                        Image("paper")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .padding()
                    }else if cpuHand == 3{
                        Image("scissors")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .padding()
                    }
                }
                
                
                HStack{
                    Button{
                        playerHand = 1
                        cpuHand = Int.random(in: 1...3)
                    }label:{
                        Image("rock")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .padding()
                            .background(Color.pink)
                            .cornerRadius(10)
                    }
                    
                    Button{
                        playerHand = 2
                        cpuHand = Int.random(in: 1...3)
                    } label:{
                        Image("paper")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Button{
                        playerHand = 3
                        cpuHand = Int.random(in: 1...3)
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
                        screenMode = "title"
                        playerHand = 0
                        cpuHand = 0
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
        }else if screenMode == "brainTraining"{
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
                                    screenMode = "finished"
                                    elapsedTime = 0
                                }
                            }
                    }
                    .frame(width: 300)
                }
                
                Text("Score : " + String(score))
                    .font(.title)
                    .padding()
                
                if instruction == 1{
                    Text("Win")
                        .font(.largeTitle)
                        .bold()
                }else if instruction == 2{
                    Text("Lose")
                        .font(.largeTitle)
                        .bold()
                }else if instruction == 3{
                    Text("Draw")
                        .font(.largeTitle)
                        .bold()
                }
                
                if cpuHand == 1{
                    Image("rock")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .padding()
                    
                }else if cpuHand == 2{
                    Image("paper")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .padding()
                }else if cpuHand == 3{
                    Image("scissors")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .padding()
                }
                
                HStack{
                    Button{
                        playerHand = 1
                        if instruction == judgeRPS(player: playerHand, cpu: cpuHand){
                            playSound(named: "correct")
                            score += 1
                        }else {
                            playSound(named: "wrong")
                            score -= 1
                        }
                        cpuHand = Int.random(in: 1...3)
                        instruction = Int.random(in: 1...3)
                    }label:{
                        Image("rock")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .padding()
                            .background(Color.pink)
                            .cornerRadius(10)
                    }
                    
                    Button{
                        playerHand = 2
                        if instruction == judgeRPS(player: playerHand, cpu: cpuHand){
                            playSound(named: "correct")
                            score += 1
                        }else {
                            playSound(named: "wrong")
                            score -= 1
                        }
                        cpuHand = Int.random(in: 1...3)
                        instruction = Int.random(in: 1...3)
                    } label:{
                        Image("paper")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Button{
                        playerHand = 3
                        if instruction == judgeRPS(player: playerHand, cpu: cpuHand){
                            playSound(named: "correct")
                            score += 1
                        }else {
                            playSound(named: "wrong")
                            score -= 1
                        }
                        cpuHand = Int.random(in: 1...3)
                        instruction = Int.random(in: 1...3)
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
            
        }else if screenMode == "finished"{
            Text("Finished!")
                .font(.largeTitle)
                .bold()
                .padding()
                .onReceive(timer) { _ in
                    elapsedTime += 0.01 //default 0.01
                    if elapsedTime >= 2{
                        screenMode = "result"
                        elapsedTime = 0
                    }
                }
            
        }else if screenMode == "result"{
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
                    screenMode = "brainTraining"
                    if score > highScore{
                        highScore = score
                    }
                    elapsedTime = 0
                    score = 0
                    instruction = Int.random(in: 1...3)
                    cpuHand = Int.random(in: 1...3)
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
                    screenMode = "title"
                    if score > highScore{
                        highScore = score
                    }
                    elapsedTime = 0
                    score = 0
                    playerHand = 0
                    cpuHand = 0
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
    //1 for rock, 2 for paper, 3 for scissors
    func judgeRPS(player: Int, cpu: Int) -> Int {
        if player == cpu {
            return 3 //draw
        }else if (player == 1 && cpu == 3) || (player == 2 && cpu == 1) || (player == 3 && cpu == 2) {
            return 1 //win
        }else {
            return 2 //lose
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
