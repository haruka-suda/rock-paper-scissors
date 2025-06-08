//
//  NumberOfDays.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/06/08.
//

import Foundation

func numberOfDays(in year: Int, month: Int) -> Int? {
    var components = DateComponents()
    components.year = year
    components.month = month
    
    let calendar = Calendar.current
    if let date = calendar.date(from: components),
       let range = calendar.range(of: .day, in: .month, for: date){
        return range.count
    }
    return nil
       
}
