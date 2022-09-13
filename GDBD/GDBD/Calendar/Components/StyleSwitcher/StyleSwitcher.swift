//
//  StyleSwitcher.swift
//  GDBD
//
//  Created by Samuel Wong on 11/9/2022.
//

import SwiftUI

struct StyleSwitcher: View {
    @Binding var calendarStyle: CalendarViewStore.CalendarCellStyle
    
    var body: some View {
        HStack(spacing: 0) {
            Button {
                calendarStyle = .individual
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "dot.square" )
                        .resizable()
                        .frame(width: 24)
                        .frame(height: 24)
                        .foregroundColor(calendarStyle == .individual ? Color(uiColor: UIColor.systemBackground) : .blue)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(calendarStyle == .individual ? .blue : Color(uiColor: UIColor.systemBackground))
            
            Button {
                calendarStyle = .continuous
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "chart.line.uptrend.xyaxis" )
                        .resizable()
                        .frame(width: 20)
                        .frame(height: 20)
                        .foregroundColor(calendarStyle == .continuous ? Color(uiColor: UIColor.systemBackground) : .blue)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(calendarStyle == .continuous ? .blue : Color(uiColor: UIColor.systemBackground))
        }
        .frame(width: 160)
        .frame(height: 32)
        .overlay {
            RoundedRectangle(cornerRadius: 4.0)
                .stroke(lineWidth: 2.0)
                .foregroundColor(.blue)
        }
    }
}
