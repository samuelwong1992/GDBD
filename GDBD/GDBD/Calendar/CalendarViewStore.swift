//
//  CalendarViewStore.swift
//  GDBD
//
//  Created by Samuel Wong on 25/8/2022.
//

import SwiftUI

class CalendarViewStore: ObservableObject {
    enum CalendarCellStyle {
        case continuous
        case individual
    }
    
    @Published var dots: [Dot] = []
    @Binding var selectedDate: Date {
        willSet {
            if (selectedDate.get(.month) != newValue.get(.month)) || (selectedDate.get(.year) != newValue.get(.year)) {
                fetchMonthlyDots(date: newValue)
            }
        }
    }
    @Published var calendarStyle: CalendarCellStyle = .individual
    
    var error: Error? {
        didSet {
            showError = error != nil
        }
    }
    var showError: Bool = false
    
    var storageService: DotService
    
    init(storageService: DotService, date: Binding<Date>) {
        self.storageService = storageService
        self._selectedDate = date

        fetchMonthlyDots()
    }
    
    func fetchMonthlyDots(date: Date? = nil) {
        storageService.fetchDotsBetweenDate(startDate: CalendarComponentViewStore.dayItemsFromSelectedDate(date: date ?? self.selectedDate).first!, endDate: CalendarComponentViewStore.dayItemsFromSelectedDate(date: date ?? self.selectedDate).last!) { [weak self] dots, error in
            guard error == nil else { self?.error = error; return }
            self?.dots = dots
        }
    }
    
    func dots(forDay day: Date) -> [Dot] {
        return dots.filter({ $0.dateTimeCreated.standardizedDate().compare(day.standardizedDate()) == .orderedSame })
    }
    
    func colour(forDay day: Date) -> Color {
        guard dots(forDay: day).count > 0 else { return .white }
        let goodCount = dots(forDay: day).filter(\.isGood).count
        let badCount = dots(forDay: day).filter({ !$0.isGood}).count
        guard badCount > 0 else { return .goodColor }
        
        let percentage = CGFloat(goodCount)/CGFloat(goodCount + badCount)
        if percentage > 0.35 {
            let yellowToGreenPercentage = (percentage - 0.2) / 0.65
            return Color.colorBetweenColors(color1: .mediumColor, color2: .goodColor, percentage: yellowToGreenPercentage)
        } else {
            let redToYellowPercentage = percentage / 0.35
            return Color.colorBetweenColors(color1: .badColor, color2: .mediumColor, percentage: redToYellowPercentage)
        }
    }
    
    func dismissError() {
        self.error = nil
    }
}
