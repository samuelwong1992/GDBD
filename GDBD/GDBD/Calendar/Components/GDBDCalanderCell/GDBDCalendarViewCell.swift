//
//  CalendarViewCell.swift
//  GDBD
//
//  Created by Samuel Wong on 10/9/2022.
//

import SwiftUI

struct GDBDCalendarViewCell: View, Equatable {
    var date: Date
    var isSelected: Bool
    var currentMonth: Int
    var yesterdaysColor: (() -> Color)
    var todaysColor: (() -> Color)
    var tomorrowsColor: (() -> Color)
    
    var style: CalendarViewStore.CalendarCellStyle
    
    var didSelect: ((Date) -> Void)
    
    var body: some View {
        VStack(spacing: 4.0) {
            Button {
                didSelect(date)
            } label: {
                Text("\(date.get(.day))")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(1, contentMode: .fill)
                    .foregroundColor(date.get(.month) == currentMonth ? .primary : .gray)
                    .overlay {
                        ZStack {
                            if Date().standardizedDate().compare(date.standardizedDate()) == .orderedSame {
                                Circle()
                                    .foregroundColor(Color.gray.opacity(0.1))
                            }
                            if isSelected {
                                Circle()
                                    .strokeBorder(lineWidth: 2.0)
                            }
                            
                        }
                    }
            }
            
            switch style {
            case .individual :
                RoundedRectangle(cornerRadius: 4.0)
                    .fill(todaysColor())
                    .padding(EdgeInsets(top: 2, leading: 8, bottom: 4, trailing: 8))
                    
            case .continuous :
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(stops: [
                            Gradient.Stop(
                                color: Color.colorBetweenColors(color1: yesterdaysColor(), color2: todaysColor(), percentage: 0.5),
                                location: 0.0
                            ),
                            Gradient.Stop(
                                color: todaysColor(),
                                location: 0.3
                            ),
                            Gradient.Stop(
                                color: todaysColor(),
                                location: 0.7
                            ),
                            Gradient.Stop(
                                color: Color.colorBetweenColors(color1: todaysColor(), color2: tomorrowsColor(), percentage: 0.5),
                                location: 1.0
                            ),
                        ]), startPoint: .leading, endPoint: .trailing)
                    )
            }
        }
    }
    
    static func == (lhs: GDBDCalendarViewCell, rhs: GDBDCalendarViewCell) -> Bool {
        let isSameDate = lhs.date.standardizedDate().compare(rhs.date.standardizedDate()) == .orderedSame
        let isSameSelectedDateStatus = lhs.isSelected == rhs.isSelected
        let isSameStyle = lhs.style == rhs.style
        
        return isSameDate && isSameSelectedDateStatus && isSameStyle
    }

}

struct CalendarViewCell_Previews: PreviewProvider {
    static var previews: some View {
        GDBDCalendarViewCell(
            date: Date(),
            isSelected: true,
            currentMonth: 12,
            yesterdaysColor: { return .green },
            todaysColor: { return .green },
            tomorrowsColor: { return .green },
            style: .individual,
            didSelect: { date -> Void in })
    }
}
