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
    let content: WeekCalendar<Content>.ContentClosure

    init(
        week: Week,
        @ViewBuilder content: @escaping WeekCalendar<Content>.ContentClosure
    ) {
        self.week = week
        self.content = content
    }

    var body: some View {
        HStack {
            ForEach(
                0..<7
            ) { i in
                let isSelected = week.dates[i] == weekStore.activeDate
                let isToday = week.dates[i] == Date.now.start()

                content(
                    isSelected, isToday, week.dates[i],
                    {
                        weekStore.select(date: week.dates[i])
                    })
            }
        }
        .padding()
    }
}

#endif
