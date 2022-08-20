//
//  Date + Utilities.swift
//  GDBD
//
//  Created by Samuel Wong on 19/8/2022.
//

import Foundation

extension Date {
    enum DayOfWeek: Int {
        case Sunday = 1
        case Monday
        case Tuesday
        case Wednesday
        case Thursday
        case Friday
        case Saturday
        
        var title: String {
            switch self {
            case .Sunday : return "Sunday"
            case .Monday : return "Monday"
            case .Tuesday : return "Tuesday"
            case .Wednesday : return "Wednesday"
            case .Thursday : return "Thursday"
            case .Friday : return "Friday"
            case .Saturday : return "Saturday"
            }
        }
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    func standardizedDate() -> Date {
        let calendar = Calendar.current
        let date = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: self)
        return date!
    }
    
    func firstDateOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func lastDateOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.firstDateOfMonth())!
    }
    
    func addingDays(numDays: Int) -> Date {
        return Calendar.current.date(byAdding: DateComponents(day: numDays), to: self)!
    }
}
