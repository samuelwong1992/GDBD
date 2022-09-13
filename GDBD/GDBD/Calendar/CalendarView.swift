//
//  CalendarView.swift
//  GDBD
//
//  Created by Samuel Wong on 19/8/2022.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject private var viewStore: CalendarViewStore
    
    init(viewStore: CalendarViewStore) {
        self.viewStore = viewStore
    }
    
    var body: some View {
        VStack {
            HStack {
                StyleSwitcher(calendarStyle: $viewStore.calendarStyle)
                
                Spacer()
                
                MonthDatePicker(date: $viewStore.selectedDate)
            }.padding()
            
            CalendarComponent<EquatableView<GDBDCalendarViewCell>>(cellForDate: { date in
                GDBDCalendarViewCell(date: date,
                                 isSelected: date.standardizedDate().compare(viewStore.selectedDate.standardizedDate()) == .orderedSame,
                                 currentMonth: viewStore.selectedDate.get(.month),
                                 yesterdaysColor: { viewStore.colour(forDay: date.addingDays(numDays: -1)) },
                                 todaysColor: { viewStore.colour(forDay: date) },
                                 tomorrowsColor: { viewStore.colour(forDay: date.addingDays(numDays: 1)) },
                                 style: viewStore.calendarStyle,
                                 didSelect: { date in
                                    viewStore.selectedDate = date
                                }
                ).equatable()
            }, viewStore: CalendarComponentViewStore(selectedDate: $viewStore.selectedDate))
            
            HStack {
                Text("\(viewStore.selectedDate.readableString(format: .formal))")
                    .font(.title2)
                    .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 4))
                Spacer()
            }
                
            
            DotsTableView(dots: viewStore.dots(forDay: viewStore.selectedDate))
        }.alert("Error", isPresented: $viewStore.showError) {
            Button("OK") {
                viewStore.dismissError()
            }
        } message: {
            Text(viewStore.error?.localizedDescription ?? "")
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        TestableCalandarView()
    }
    
    struct TestableCalandarView: View {
        @State var selectedDate: Date = Date()
        
        var body: some View {
            CalendarView(viewStore: CalendarViewStore(storageService: DotCoreDataService(persistenceController: PersistenceController.preview), date: $selectedDate))
        }
    }
}
