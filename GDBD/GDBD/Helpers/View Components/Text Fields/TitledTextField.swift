//
//  TitledTextField.swift
//  GDBD
//
//  Created by Samuel Wong on 22/8/2022.
//

import SwiftUI

struct TitledTextField: View {
    @Binding var text: String
    var placeholder: String
    var placeholderExtras: String?
    
    var hasText: Bool {
        return !text.isEmpty
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.primary.opacity(hasText ? 1.0 : 0.4))
                
                TextField("", text: $text, axis: .vertical)
                    .lineLimit(4...6)
                    .padding(EdgeInsets(
                        top: 4,
                        leading: 8,
                        bottom: 4,
                        trailing: 8
                    ))
            }
            .background(Color(UIColor.systemBackground))
            
            HStack(alignment: .top, spacing: 2.0) {
                Text("\(placeholder)")
                    .background(Color(UIColor.systemBackground))
                    .opacity(hasText ? 1.0 : 0.6)
                    .padding(EdgeInsets(
                        top: hasText ? -12 : 4,
                        leading: hasText ? 0 : 10,
                        bottom: 0,
                        trailing: 0
                    ))
                    .scaleEffect(hasText ? 0.8 : 1.0)
                    .animation(.spring(), value: hasText)
                    .allowsHitTesting(false)
                
                if let placeholderExtras = placeholderExtras {
                    Text("\(placeholderExtras)")
                        .background(Color(UIColor.systemBackground))
                        .opacity(hasText ? 0.0 : 0.6)
                        .padding(EdgeInsets(
                            top: 4,
                            leading: 0,
                            bottom: 0,
                            trailing: 0
                        ))
                        .animation(.spring(), value: hasText)
                        .allowsHitTesting(false)
                }
            }.padding(0)
                
        }.padding(.vertical)
    }
}
