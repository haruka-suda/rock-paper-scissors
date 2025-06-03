//
//  DebugModeView.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/05/29.
//

import SwiftUI

struct DebugModeView: View {
    @EnvironmentObject var appState: AppState
    @Binding var screenMode: ScreenMode
    
    
    var body: some View {
        Button{
            appState.highScoreHistory["20250501"] = 10
            appState.highScoreHistory["20250502"] = 20
            appState.highScoreHistory["20250503"] = 30
            appState.highScoreHistory["20250504"] = 40
            appState.highScoreHistory["20250505"] = 50
            appState.highScoreHistory["20250506"] = 10
            appState.highScoreHistory["20250507"] = 50
            appState.highScoreHistory["20250508"] = 20
            appState.highScoreHistory["20250509"] = 40
            appState.highScoreHistory["20250510"] = 30
            UserDefaults.standard.set(appState.highScoreHistory, forKey: "highScoreHistory")
        }label:{
            Text("set 10 days score history data")
        }
        
        Button{
            screenMode = .title
        }label:{
            Text("return to the title")
        }
    }
}
