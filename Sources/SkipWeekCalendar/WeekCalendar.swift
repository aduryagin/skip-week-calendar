//
//  ContentView.swift
//  skip-week-calendar
//
//  Created by Alexey Duryagin on 23/09/2024.
//


import SwiftUI

public struct WeekCalendar<Content: View>: View {
    public typealias ContentClosure = (
        _ isSelected: Bool,
        _ isToday: Bool,
        _ date: Date,
        _ onTap: @escaping () -> Void
    ) -> Content

    #if !SKIP
    @StateObject private var weekStore: WeekStore = WeekStore()
    #endif

    @Binding private var selection: Date
    
    public let content: ContentClosure
    
    
    public init(
        selection: Binding<Date>? = nil,
        @ViewBuilder content: @escaping ContentClosure
    ) {
        self.content = content
        #if !SKIP
        self._selection = selection ?? .constant(Date.now)
        #else
        self.selection = selection?.wrappedValue ?? Date.now
        #endif
    }
    
    #if SKIP
    @Composable public override func ComposeContent(context: ComposeContext) {
        WeekCalendarAndroid(selection: selection.kotlin()) { isSelected, isToday, date, onTap in
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
        WeekTabs() { week in
            WeekView(
                week: week,
                content: content
            )
        }
        .environmentObject(weekStore)
        .task(id: selection) {
            weekStore.select(date: selection)
        }
    }
    #endif
}
