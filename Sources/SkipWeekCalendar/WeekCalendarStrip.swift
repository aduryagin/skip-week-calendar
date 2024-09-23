//
//  WeekCalendarStrip.swift
//  skip-week-calendar
//
//  Created by Alexey Duryagin on 23/09/2024.
//


#if !SKIP
import SwiftUI

struct WeekCalendarStrip<Content: View>: View {
    @StateObject private var weekStore: WeekStore = WeekStore()
    
    let content: (
        _ isSelected: Bool,
        _ isToday: Bool,
        _ date: Date,
        _ onTap: @escaping () -> Void
    ) -> Content
    
    var body: some View {
        WeekTabs() { week in
            WeekView(
                week: week,
                content: content
            )
        }
        .environmentObject(weekStore)
    }
}
#endif
