//
//  NormalModeView.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/05/11.
//

import SwiftUI

struct NormalModeView: View {
    @EnvironmentObject var appState: AppState
    @Binding var instruction: RPSResult
    @Binding var playerHand: RPSHand
    @Binding var cpuHand: RPSHand
    @Binding var screenMode: ScreenMode
    
    var body: some View {
        VStack{
            if screenMode == .normalFirst{
                Text("choose_your_hand".localized)
                    .font(.largeTitle)
                    .bold()
                    .padding()
            }else if screenMode == .normalSecond && judgeRPS(player: playerHand, cpu: cpuHand) == .win{
                Text("normal_won".localized)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.green)
                    .padding()
            }else if screenMode == .normalSecond && judgeRPS(player: playerHand, cpu: cpuHand) == .lose{
                Text("normal_lose".localized)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.blue)
                    .padding()
            }else if screenMode == .normalSecond && judgeRPS(player: playerHand, cpu: cpuHand) == .draw{
                Text("normal_draw".localized)
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
                    Text("return_to_the_title".localized)
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

