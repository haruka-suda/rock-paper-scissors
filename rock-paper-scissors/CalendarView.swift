//
//  CalendarView.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/05/24.
//

import SwiftUI
import Foundation

struct CalendarView: View {
    @EnvironmentObject var appState: AppState
    //@Binding var screenMode: ScreenMode
    @State private var displayedDate = Date()
    
    let now = Date()
    let calendar = Calendar.current
    
    var displayedYear: Int {
        calendar.component(.year, from: displayedDate)
    }
    var displayedMonth: Int {
        calendar.component(.month, from: displayedDate)
    }
    var displayedComponents: DateComponents {
        DateComponents(year: displayedYear, month: displayedMonth, day: 1)
    }
    var firstWeekday: Int? {
        if let date = calendar.date(from: displayedComponents){
            return calendar.component(.weekday, from:date)
        }else {
            return nil
        }
    }
    var days: Int? {
        numberOfDays(in: displayedYear, month: displayedMonth)
    }
    
    var currentYear: Int {
        calendar.component(.year, from: now)
    }
    var currentMonth: Int {
        calendar.component(.month, from: now)
    }
    
    
//    let components = DateComponents(year: 2025, month: 6, day: 1)
//
//    
//    var date: Date {
//        calendar.date(from: components)!
//    }
//    var startWeekday: Int{
//        calendar.component(.weekday, from: date)
//    }
    var monthFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "LLLL"
        return formatter
    }
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        
        let todayComponents = calendar.dateComponents([.year, .month, .day, .weekday], from: now)
       
        
        
        VStack{
            HStack{
                Button{
                    displayedDate = Calendar.current.date(byAdding: .month, value: -1, to: displayedDate)!
                } label: {
                    Image(systemName: "arrow.left.circle.fill")
                        .font(.title)
                }.padding()
                
                if let year = displayedComponents.year{
                    Text(String(describing: year))
                        .font(.title)
                       
                }
                let monthName = monthFormatter.string(from: displayedDate)
                Text(monthName)
                    .font(.title)
                
                Button{
                    displayedDate = Calendar.current.date(byAdding: .month, value: 1, to: displayedDate)!
                } label: {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.title)
                }.padding()
                 
            }
            
            
           // Text("\(todayComponents.year ?? 0)")
           // Text("\(todayComponents.month ?? 0)")
            
            LazyVGrid(columns: columns, spacing: 10){
                // Day of week label
                ForEach(["Sun","Mon","Tue","Wed","Thu","Fri","Sat"], id: \.self){ day in
                    Text(day)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                
                // Insert empty grids for offset (only if needed)
                if firstWeekday! > 1 {
                    ForEach(0..<(firstWeekday!-1), id: \.self){ index in
                        Text("")
                            .id("empty-\(index)")
                            .frame(width: 40, height: 40)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(Circle())
                    }
                }
                
                //Date label(1...31)
                ForEach(1...days!, id: \.self) { day in
                    if day == todayComponents.day! && displayedMonth == currentMonth {
                        
                        ZStack {
                            let tag = makeTagString(year: displayedYear, month: displayedMonth, day: day)
                            if appState.highScoreHistory.keys.contains(tag){
                              
                                    Image(systemName: "star.fill")
                                        .font(.title)
                                        .foregroundStyle(.yellow)
                            }
                            
                            Text("\(day)")
                                .frame(width: 40, height: 40)
                                .background(Color.red.opacity(0.4))
                                .clipShape(Circle())
                        }
                    }else{
                        let tag = makeTagString(year: displayedYear, month: displayedMonth, day: day)
                        if appState.highScoreHistory.keys.contains(tag){
                            ZStack{
                                Image(systemName: "star.fill")
                                    .font(.title)
                                    .foregroundStyle(.yellow)
                                
                                Text("\(day)")
                                    .frame(width: 40, height: 40)
                                    .background(Color.blue.opacity(0))
                                    .clipShape(Circle())
                            }
                        }else{
                            Text("\(day)")
                                .frame(width: 40, height: 40)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Circle())
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CalendarView().environmentObject(AppState())
}
