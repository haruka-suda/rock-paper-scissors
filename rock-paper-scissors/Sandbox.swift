//
//  Sandbox.swift
//  rock-paper-scissors
//
//  This file is used for testing and experimenting with components during development.
//  Safe to break, rewrite, and delete as needed.
//
//  Created by Mac mini on 2025/05/29.
//


import Foundation
import SwiftUI

struct Sandbox: View {
    
    @EnvironmentObject var appState: AppState
    
    
    var body: some View {
        let now = Date()
        VStack{
            Text("now.yyyymmddTag" + now.yyyymmddTag)
         
            Button{
                appState.highScoreHistory[now.yyyymmddTag] = 30
                //UserDefaults.standard.set(appState.highScoreHistory, forKey: "highScoreHistory")
            } label: {
                Text("HighScoreHistory = 30")
            }
            
            Button{
                appState.highScoreHistory[now.yyyymmddTag] = 50
                //UserDefaults.standard.set(appState.highScoreHistory, forKey: "highScoreHistory")
            } label: {
                Text("HighScoreHistory = 50")
            }
            
            Text("HighScore is : \(appState.highScoreHistory[now.yyyymmddTag])")
        }
        
        
    }
}

#Preview {
    Sandbox().environmentObject(AppState())
}
