//
//  Week.swift
//  skip-week-calendar
//
//  Created by Alexey Duryagin on 23/09/2024.
//


#if !SKIP
import Foundation
#if os(iOS)
import UIKit
#endif
import SwiftUI

struct Week {
    let index: Int
    let dates: [Date]
    var referenceDate: Date
}

enum TimeDirection {
    case future
    case past
    case unknown
}

@MainActor
class WeekStore: ObservableObject {
    
    @Published var activeTab: Int = 1
    @Published var weeks: [Week] = []
    @Published var selectedDate: Date {
        didSet {
            Task {
                weeks = await calcWeeks(with: selectedDate)
                activeTab = 1
            }
        }
    }
    @Published var activeDate = Date().start()
  
    init(with date: Date? = nil) {
        self.selectedDate = Calendar.current.startOfDay(for: date ?? Date.now)
        self.activeDate = self.selectedDate
        
        Task {
            weeks = await calcWeeks(with: selectedDate)
        }

        #if os(iOS)
        // Set up the observer for the significant time change notification
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleTimeChange),
            name: UIApplication.significantTimeChangeNotification,
            object: nil
        )
        #endif
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func handleTimeChange() {
        Task { @MainActor in
            select(date: Date())
            
            weeks = await calcWeeks(with: selectedDate)
        }
    }
    
    nonisolated func calcWeeks(with date: Date) async -> [Week] {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        
        guard let startOfWeek = calendar.date(from: components) else { return [] }

        async let prev = week(
            for: calendar.date(byAdding: .weekOfYear, value: -1, to: startOfWeek)!,
            with: -1
        )
        async let current = week(for: startOfWeek, with: 0)
        async let future = week(
            for: calendar.date(byAdding: .weekOfYear, value: 1, to: startOfWeek)!,
            with: 1
        )

        return await [prev, current, future]
    }
    
    nonisolated func week(for date: Date, with index: Int) async -> Week {
        var result: [Date] = .init()
        
        let calendar = Calendar.current

        guard let startOfWeek = calendar.date(
            from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)) else {
            return .init(index: index, dates: [], referenceDate: date)
        }

        (0...6).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeek) {
                result.append(weekday)
            }
        }

        return .init(index: index, dates: result, referenceDate: date)
    }
    
    func select(date: Date) {
        selectedDate = Calendar.current.startOfDay(for: date)
        activeDate = selectedDate
    }

    func update(to direction: TimeDirection) {
        switch direction {
        case .future:
            selectedDate = Calendar.current.date(byAdding: .day, value: 7, to: selectedDate)!

        case .past:
            selectedDate = Calendar.current.date(byAdding: .day, value: -7, to: selectedDate)!

        case .unknown:
            selectedDate = selectedDate
        }
    }
}
#endif
