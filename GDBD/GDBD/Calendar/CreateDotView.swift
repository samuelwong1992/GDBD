//
//  CreateDotView.swift
//  GDBD
//
//  Created by Samuel Wong on 12/8/2022.
//

import SwiftUI

struct CreateDotView: View {
    @State var text: String = ""
    @State var date: Date = Date()
    
    var body: some View {
        VStack {
            Text("Adding a Good Dot!")
                .font(.title)
            
            Form {
                DatePicker(
                    "When",
                    selection: $date,
                    in: ...Date(),
                    displayedComponents: [.date, .hourAndMinute]
                )
                VStack(alignment: .leading) {
                    Text("Description")
                    TextEditor(text: $text)
                        .frame(height: 120)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(.gray)
                        )
                }
                .padding(.vertical)
            }
            
            HStack {
                SecondaryButton(title: "Cancel") {
                    
                }
                
                PrimaryButton(title: "Submit") {
                    
                }
            }
        }
        .padding()
    }
}

struct CreateDotView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CreateDotView().preferredColorScheme(.dark)
        }
    }
}


