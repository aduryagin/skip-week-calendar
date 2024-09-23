//
//  WeekView.swift
//  skip-week-calendar
//
//  Created by Alexey Duryagin on 23/09/2024.
//


#if !SKIP

import SwiftUI

struct WeekView<Content: View>: View {
    @EnvironmentObject var weekStore: WeekStore
    
    var week: Week
    let content: (
        _ isSelected: Bool,
        _ isToday: Bool,
        _ date: Date,
        _ onTap: @escaping () -> Void
    ) -> Content
    
    init(
        week: Week,
        @ViewBuilder content: @escaping (_ isSelected: Bool, _ isToday: Bool, _ date: Date, _ onTap: @escaping () -> Void) -> Content
    ) {
        self.week = week
        self.content = content
    }
    
    func getBorderAccentColor(active: Bool, today: Bool) -> Color {
        if (active) { return Color.accentColor }
        if (today) { return Color.accentColor.opacity(0.5) }
        
        return Color.clear
    }

    var body: some View {
        HStack {
            ForEach(
                0..<7
            ) { i in
                let isSelected = week.dates[i] == weekStore.activeDate
                let isToday = week.dates[i] == Date.now.start()
                
                content(isSelected, isToday, week.dates[i], {
                    weekStore.select(date: week.dates[i])
                })
            }
        }
        .padding()
    }
}

#endif
