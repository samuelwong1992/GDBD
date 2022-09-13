//
//  CalendarCell.swift
//  GDBD
//
//  Created by Samuel Wong on 13/9/2022.
//

import SwiftUI

struct CalendarCell: View {
    private var date: Date
    private var isSelected: Bool
    private var isCurrentMonth: Bool
    private var onSelection: ((Date) -> Void)
    
    internal init(date: Date, isSelected: Bool, isCurrentMonth: Bool, onSelection: @escaping ((Date) -> Void)) {
        self.date = date
        self.isSelected = isSelected
        self.isCurrentMonth = isCurrentMonth
        self.onSelection = onSelection
    }
    
    var body: some View {
        Button {
            onSelection(date)
        } label: {
            Text("\(date.get(.day))")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fill)
                .foregroundColor(isCurrentMonth ? .primary : .gray)
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
    }
}

struct CalendarCell_Previews: PreviewProvider {
    static var previews: some View {
        CalendarCell(date: Date(), isSelected: true, isCurrentMonth: true, onSelection: {date -> Void in})
    }
}
