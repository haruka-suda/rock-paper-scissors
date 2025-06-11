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
            Text("High Score History")
                .font(.title)
                .fontWeight(.bold)
                
                Chart(appState.chartData) { item in
                    LineMark(
                        x: .value("Date", item.date),
                        y: .value("High Score", item.highScore)
                    )
                    .lineStyle(StrokeStyle(lineWidth: 5))
                    .foregroundStyle(.orange)
                    .interpolationMethod(.cardinal)
                }
                .chartXAxis{
                    AxisMarks(preset: .aligned, position: .bottom){ value in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel()
                            .font(.system(size:18, weight: .bold))
                            .foregroundStyle(.black)
                    }
                }
                .chartYAxis{
                    AxisMarks(position: .leading){ value in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel()
                            .font(.system(size:18, weight: .bold))
                            .foregroundStyle(.black)
                    }
                }
                .frame(height: 400)
                .padding()

            Button{
                screenMode = .title
            }label:{
                Text("return to the title")
            }
        }
    }
}


