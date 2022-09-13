//
//  CalendarComponent.swift
//  GDBD
//
//  Created by Samuel Wong on 10/9/2022.
//

import SwiftUI

class CalendarComponentViewStore: ObservableObject {
    internal init(selectedDate: Binding<Date>) {
        self._selectedDate = selectedDate
    }
    
    @Binding var selectedDate: Date
    
    static func dayItemsFromSelectedDate(date: Date) -> [Date] {
        var toReturn: [Date] = []
        let firstDay = date.firstDateOfMonth()
        
        for i in (1 ..< firstDay.get(.weekday)).reversed() {
            toReturn.append(firstDay.addingDays(numDays: (-i)))
        }
        for i in 0 ..< date.lastDateOfMonth().get(.day) {
            toReturn.append(firstDay.addingDays(numDays: i))
        }
        for i in 1 ..< 8 - date.lastDateOfMonth().get(.weekday) {
            toReturn.append(date.lastDateOfMonth().addingDays(numDays: i))
        }
        
        return toReturn
    }
}

struct CalendarComponent<Content>: View where Content: View {
    internal init(@ViewBuilder cellForDate: @escaping(Date) -> Content? = { _ in nil }, viewStore: CalendarComponentViewStore) {
        self.cellForDate = cellForDate
        self.viewStore = viewStore
    }
    
    //TODO: Move View Cell to completion block
    // Implement basic calander view cell
    // Refactor existing Calendar View Cell to DotCalendarViewCell
    // Render if completion block exists
    // Move View Store to requirements only
    
    let cellForDate: (Date) -> Content?
    @ObservedObject var viewStore: CalendarComponentViewStore
    
    private let gridColumns: [GridItem] = [
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0),
    ]
    
    var body: some View {
        VStack {
            HStack {
                ForEach(1..<8, id: \.self) { i in
                    let day = Date.DayOfWeek(rawValue: i)!.title
                    Text(day[day.startIndex ..< day.index(day.startIndex, offsetBy: 2)]).frame(maxWidth: .infinity)
                }
            }
            
            LazyVGrid(columns: gridColumns) {
                ForEach(0 ..< CalendarComponentViewStore.dayItemsFromSelectedDate(date: viewStore.selectedDate).count, id: \.self) { i in
                    VStack(spacing: 0) {
                        let date = CalendarComponentViewStore.dayItemsFromSelectedDate(date: viewStore.selectedDate)[i]
                        if let cellBlock = cellForDate(date) {
                            cellBlock
                        } else {
                            CalendarCell(date: date,
                                         isSelected: date.standardizedDate().compare(viewStore.selectedDate.standardizedDate()) == .orderedSame,
                                         isCurrentMonth: viewStore.selectedDate.get(.month) == date.get(.month),
                                         onSelection: { date in
                                            viewStore.selectedDate = date
                                        })
                        }
                        
                        Rectangle()
                            .fill(Color.secondary)
                            .frame(height: 1)
                    }
                    
                }
            }
        }
    }
}

struct CalendarComponent_Previews: PreviewProvider {
    static var previews: some View {
        TestableCalendarComponent()
    }
    
    struct TestableCalendarComponent: View {
        @State var date: Date = Date()
        
        var body: some View {
            CalendarComponent<AnyView>(viewStore: CalendarComponentViewStore(selectedDate: $date))
        }
        
    }
}
