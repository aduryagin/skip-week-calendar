# SkipWeekCalendar

![Preview](./preview.gif)

## Installation

Update Package.swift
```swift
dependencies: [
    // Other dependencies here
    .package(url: "https://github.com/aduryagin/skip-week-calendar.git", branch: "main")
],
targets: [
    .target(
        name: "YourProjectName",
        dependencies: [
            // List your target dependencies here, including the new package
            .product(name: "SkipWeekCalendar", package: "skip-week-calendar")
        ]
    ),
]
```

## Usage

```swift
import SwiftUI
import SkipWeekCalendar

public struct ContentView: View {
    public var body: some View {
        WeekCalendar { isSelected, isToday, date, onTap in
            // You can replace this View with your own
            WeekDayView(
                isSelected: isSelected,
                isToday: isToday,
                date: date,
                onTap: onTap
            )
        }
    }
}

```
