//
//  ContentView.swift
//  skip-week-calendar
//
//  Created by Alexey Duryagin on 23/09/2024.
//


import SwiftUI

public struct WeekCalendar<Content: View>: View {
    
    public let content: (
        _ isSelected: Bool,
        _ isToday: Bool,
        _ date: Date,
        _ onTap: @escaping () -> Void
    ) -> Content
    
    public init(@ViewBuilder content: @escaping (
        _ isSelected: Bool,
        _ isToday: Bool,
        _ date: Date,
        _ onTap: @escaping () -> Void
    ) -> Content) {
        self.content = content
    }

    public var body: some View {
        #if SKIP
        ComposeView { ctx in
            WeekCalendarStripAndroid { isSelected, isToday, date, onTap in
                content(
                    isSelected: isSelected,
                    isToday: isToday,
                    date: Date(platformValue: date),
                    onTap: onTap
                ).Compose(context: ctx.content())
            }
        }
        #else
        WeekCalendarStrip(content: content)
        #endif
    }
}
