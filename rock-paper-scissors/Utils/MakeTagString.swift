//
//  makeTagString.swift
//  rock-paper-scissors
//
//  Created by Mac mini on 2025/06/08.
//

import Foundation

func makeTagString(year: Int, month: Int, day: Int) -> String {
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    
    let calendar = Calendar.current
    if let date = calendar.date(from: components){
        return date.yyyymmddTag
    }else {
        return ""
    }
}
