//
//  FinishedView.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/05/14.
//

import SwiftUI

struct FinishedView: View {
    @EnvironmentObject var appState: AppState
    @Binding var screenMode: ScreenMode
    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

    var body: some View {
        Text("finished_label".localized)
            .font(.largeTitle)
            .bold()
            .foregroundColor(Color("primaryBlue"))
            .padding()
            .onReceive(timer) { _ in
                appState.elapsedTime += 0.01 //default 0.01
                if appState.elapsedTime >= 2{
                    screenMode = .result
                    appState.elapsedTime = 0
                }
            }
    }
}

