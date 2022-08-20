//
//  BaseButton.swift
//  GDBD
//
//  Created by Samuel Wong on 19/8/2022.
//

import SwiftUI

struct BaseButtonStyle: ButtonStyle {
    var backgroundColor: Color
    var foregroundColor: Color
    var borderColor: Color?
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body.bold())
            .padding(.horizontal)
            .foregroundColor(foregroundColor)
            .frame(height: 48.0)
            .background(
                RoundedRectangle(cornerRadius: 8).fill(backgroundColor)
                )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(borderColor ?? backgroundColor, lineWidth: 1)
                )
    }
}
