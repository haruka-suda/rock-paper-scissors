//
//  CalendarView.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/05/24.
//

import SwiftUI
import Foundation

struct CalendarView: View {
    let calendar = Calendar.current
    let components = DateComponents(year: 2025, month: 5, day: 1)
    
    var date: Date {
        calendar.date(from: components)!
    }
    var weekday: Int{
        calendar.component(.weekday, from: date)
    }
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10){
            // Day of week label
            ForEach(["Sun","Mon","Tue","Wed","Thu","Fri","Sat"], id: \.self){ day in
                Text(day)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            
            // Insert empty grids for offset (only if needed)
            if weekday > 1 {
                ForEach(0..<(weekday-1), id: \.self){ index in
                    Text("")
                        .id("empty-\(index)")
                        .frame(width: 40, height: 40)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(Circle())
                }
            }
            
            //Date label(1...31)
            ForEach(1...31, id: \.self) { day in
                Text("\(day)")
                    .frame(width: 40, height: 40)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
            }
        }
    }
}

#Preview {
    CalendarView()
}
