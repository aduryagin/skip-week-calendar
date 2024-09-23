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

    #if SKIP
    @Composable public override func ComposeContent(context: ComposeContext) {
        WeekCalendarAndroid { isSelected, isToday, date, onTap in
            content(
                isSelected,
                isToday,
                Date(platformValue: date),
                onTap
            ).Compose(context: context.content())
        }
    }
    #else
    public var body: some View {
        WeekCalendarStrip(content: content)
    }
    #endif
}
