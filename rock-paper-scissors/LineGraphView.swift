//
//  LineGraphView.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/05/29.
//

import Charts
import SwiftUI

struct LineGraphView: View {
    @EnvironmentObject var appState: AppState
    @Binding var screenMode: ScreenMode
    
    var body: some View {
        VStack{
            Chart(appState.chartData) { item in
                LineMark(
                    x: .value("Date", item.date),
                    y: .value("High Score", item.highScore)
                )
            }
            .frame(height: 200)
            .padding()
            

            Button{
                screenMode = .title
            }label:{
                Text("return to the title")
            }
        }
    }
}


