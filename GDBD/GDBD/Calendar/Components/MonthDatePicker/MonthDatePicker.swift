//
//  MonthDatePicker.swift
//  GDBD
//
//  Created by Samuel Wong on 11/9/2022.
//

import SwiftUI

struct MonthDatePicker: View {
    
    @Binding var date: Date
    
    var body: some View {
        HStack {
            Button {
                date = date.addingMonths(numMonths: -1)
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color.secondary)
            }
            
            DatePicker("", selection: $date, displayedComponents: .date)
                .labelsHidden()
            
            
            Button {
                date = date.addingMonths(numMonths: 1)
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.secondary)
            }
        }
    }
}
