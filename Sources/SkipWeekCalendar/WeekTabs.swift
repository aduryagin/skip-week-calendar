//
//  WeekTabs.swift
//  skip-week-calendar
//
//  Created by Alexey Duryagin on 23/09/2024.
//


#if !SKIP
import SwiftUI

struct WeekTabs<Content: View>: View {
    @EnvironmentObject var weekStore: WeekStore

    @State private var direction: TimeDirection = .unknown

    let content: (_ week: Week) -> Content

    init(@ViewBuilder content: @escaping (_ week: Week) -> Content) {
        self.content = content
    }

    var body: some View {
        TabView(selection: $weekStore.activeTab) {
            if weekStore.weeks.count > 0 {
                content(weekStore.weeks[0])
                    .frame(maxWidth: .infinity)
                    .tag(0)

                content(weekStore.weeks[1])
                    .frame(maxWidth: .infinity)
                    .tag(1)
                    .onDisappear() {
                        guard direction != .unknown else { return }
                        
                        weekStore.update(to: direction)
                        
                        direction = .unknown
                    }

                content(weekStore.weeks[2])
                    .frame(maxWidth: .infinity)
                    .tag(2)
            }
        }
        #if os(iOS)
        .tabViewStyle(.page(indexDisplayMode: .never))
        #endif
        .onChange(of: weekStore.activeTab) { value in
            if value == 0 {
                direction = .past
            } else if value == 2 {
                direction = .future
            }
        }
    }
}


struct WeeksTabsView_Previews: PreviewProvider {
    static var previews: some View {
        WeekTabs() { week in
            WeekView(week: week) { isSelected, isToday, date, onTap in
                WeekDayView(isSelected: isSelected, isToday: isToday, date: date, onTap: onTap)
            }
        }.environmentObject(WeekStore())
    }
}

#endif
