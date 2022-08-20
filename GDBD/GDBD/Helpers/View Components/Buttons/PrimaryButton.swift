//
//  PrimaryButton.swift
//  GDBD
//
//  Created by Samuel Wong on 19/8/2022.
//

import SwiftUI

struct PrimaryButton: View {
    var title: String
    var onPress: (() -> Void)
    
    var body: some View {
        Button(action: onPress) {
            Text(title)
        }
        .buttonStyle(BaseButtonStyle(backgroundColor: .blue, foregroundColor: Color.white))

    }
}
