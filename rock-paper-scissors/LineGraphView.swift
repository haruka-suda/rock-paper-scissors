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

        
        ZStack{
            Color("primaryBlue")
                .ignoresSafeArea()
                .onAppear{
                    appState.updateChartData()
                }
            
            VStack{
                Text("High Score History")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Chart(appState.chartData) { item in
                    LineMark(
                        x: .value("Date", item.date),
                        y: .value("High Score", item.highScore)
                    )
                    .lineStyle(StrokeStyle(lineWidth: 5))
                    .foregroundStyle(Color("timeBar"))
                }
                .chartXAxis{
                    AxisMarks(preset: .aligned, position: .bottom){ value in
                        AxisGridLine()
                            .foregroundStyle(Color.white)
                        AxisTick()
                            .foregroundStyle(Color.white)
                        AxisValueLabel()
                            .font(.system(size:18, weight: .bold))
                            .foregroundStyle(.white)
                    }
                }
                .chartYAxis{
                    AxisMarks(position: .leading){ value in
                        AxisGridLine()
                            .foregroundStyle(Color.white)
                        AxisTick()
                            .foregroundStyle(Color.white)
                        AxisValueLabel()
                            .font(.system(size:18, weight: .bold))
                            .foregroundStyle(.white)
                    }
                }
                .frame(height: 400)
                .padding()
                
            }
        }
    }
}


