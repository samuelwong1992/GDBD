//
//  CalendarView.swift
//  GDBD
//
//  Created by Samuel Wong on 19/8/2022.
//

import SwiftUI

struct CalendarView: View {
    
    private var gridColumns: [GridItem] = [
        GridItem(),
        GridItem(),
        GridItem(),
        GridItem(),
        GridItem(),
        GridItem(),
        GridItem(),
    ]
    
    private var selectedDate: Date = Date().addingDays(numDays: 0)
    
    func dayItemsFromSelectedDate() -> [Date] {
        var toReturn: [Date] = []
        let firstDay = selectedDate.firstDateOfMonth()
        
        for i in (1 ..< firstDay.get(.weekday)).reversed() {
            toReturn.append(firstDay.addingDays(numDays: (-i)))
        }
        for i in 0 ..< selectedDate.lastDateOfMonth().get(.day) {
            toReturn.append(firstDay.addingDays(numDays: i))
        }
        for i in 1 ..< 8 - selectedDate.lastDateOfMonth().get(.weekday) {
            toReturn.append(selectedDate.lastDateOfMonth().addingDays(numDays: i))
        }
        
        return toReturn
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "chevron.left")
                }
                
                Text ("Month, Year")
                
                Button {
                    
                } label: {
                    Image(systemName: "chevron.right")
                }
            }.padding()
            
            HStack {
                ForEach(1..<8, id: \.self) { i in
                    let day = Date.DayOfWeek(rawValue: i)!.title
                    Text(day[day.startIndex ..< day.index(day.startIndex, offsetBy: 2)]).frame(maxWidth: .infinity)
                }
            }
            
            LazyVGrid(columns: gridColumns) {
                ForEach(0..<dayItemsFromSelectedDate().count, id: \.self) { i in
                    let date = dayItemsFromSelectedDate()[i]
                    Text("\(date.get(.day))")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .aspectRatio(1, contentMode: .fill)
                        .foregroundColor(date.get(.month) == selectedDate.get(.month) ? .primary : .gray)
                        
                }
            }
            
            Text("\(selectedDate.firstDateOfMonth())")
            Spacer()
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
