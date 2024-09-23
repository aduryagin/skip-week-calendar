//
//  DayView.swift
//  skip-week-calendar
//
//  Created by Alexey Duryagin on 23/09/2024.
//


import SwiftUI

public struct WeekDayView: View {
    let isSelected: Bool
    let isToday: Bool
    let date: Date
    let onTap: () -> Void
    
    public init(isSelected: Bool, isToday: Bool, date: Date, onTap: @escaping () -> Void) {
        self.isSelected = isSelected
        self.isToday = isToday
        self.date = date
        self.onTap = onTap
    }
    
    func getBorderAccentColor() -> Color {
        if (isSelected) { return Color.accentColor }
        if (isToday) { return Color.accentColor.opacity(0.5) }
        
        return Color.clear
    }
    
    public var body: some View {
        let borderColor = getBorderAccentColor()
        
        VStack(spacing: 3) {
            Text(
                date.toString(
                    format: "EEE"
                ).uppercased()
            )
            .font(
                Font.system(
                    size: 15
                )
            )
            .foregroundColor(
                isSelected ? Color.accentColor : Color.gray
            )
            .fontWeight(Font.Weight.semibold)
            .frame(
                maxWidth: CGFloat.infinity
            )
            
            Text(
                date.toString(
                    format: "d"
                )
            )
            .font(
                Font.system(
                    size: 15
                )
            )
            .frame(
                maxWidth: CGFloat.infinity
            )
            .foregroundColor(
                isSelected ? Color.accentColor : Color.gray
            )
            .fontWeight(isSelected ? Font.Weight.semibold : Font.Weight.regular)
        }
        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
        .cornerRadius(10)
        .overlay(
            alignment: Alignment.center,
            content: { RoundedRectangle(cornerRadius: 10).stroke(style: StrokeStyle(lineWidth: 2)).foregroundStyle(borderColor) }
        )
        #if SKIP
        .padding(EdgeInsets(top: 1, leading: 3, bottom: 1, trailing: 3))
        #endif
        .onTapGesture {
            onTap()
        }
        .frame(maxWidth: CGFloat.infinity)
    }
}
