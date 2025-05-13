//
//  MakeHandButton.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/05/13.
//

import SwiftUI

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
