//
//  Date.swift
//  skip-week-calendar
//
//  Created by Alexey Duryagin on 23/09/2024.
//

import Foundation

extension Date {
    func start() -> Date {
        #if !SKIP
        let calendar = Calendar.current
        let startOfToday = calendar.startOfDay(for: self)
        
        return startOfToday
        #else
        return Date.now
        #endif
    }
    
    func toString(format: String) -> String {
        let calendar = Calendar.current

        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.dateFormat = format
        let result = formatter.string(from: self)

        return result
    }
}
