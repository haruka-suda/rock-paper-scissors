//
//  ContentView.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/04/30.
//


import SwiftUI

struct ContentView: View {
    @State var screenMode = "title"
    
    //hands 0:initialized, 1:rock, 2:paper, 3:scissors
    @State var playerHand = 0
    @State var cpuHand = 0
    
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
                        screenMode = "brainTrainig"
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
                }
                VStack{
                    
                    
                    Button{
                        screenMode = "title"
                    } label: {
                        Text("Return to the Title")
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
        }else if screenMode == "brainTraining"{
            
        }else if screenMode == "result"{
            
        }
        
        
    }
}

#Preview {
    ContentView()
}
