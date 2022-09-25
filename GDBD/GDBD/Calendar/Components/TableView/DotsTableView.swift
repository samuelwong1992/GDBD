//
//  DotsTableView.swift
//  GDBD
//
//  Created by Samuel Wong on 11/9/2022.
//

import SwiftUI

struct DotsTableView: View {
    private var dots: [Dot]
    
    internal init(dots: [Dot]) {
        self.dots = dots
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0 ..< dots.count, id: \.self) { i in
                    let dot = dots[i]
                    VStack(alignment: .leading) {
                        HStack {
                            Text( dot.dateTimeCreated.readableString(format: .timeDayMonthYear)
                            )
                            Spacer()
                            Circle()
                                .fill(dot.isGood ? Color.goodColor : Color.badColor)
                                .frame(width: 20)
                                .frame(height: 20)
                        }
                        
                        Text(dot.category?.name ?? "No Category")
                        Text(dot.text ?? "No Description")
                        
                        Rectangle()
                            .fill(Color.secondary)
                            .frame(height: 1)
                    }
                    .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                }
            }
        }
    }
}

struct DotsTableView_Previews: PreviewProvider {
    static var previews: some View {
        DotsTableView(dots: [
            Dot(dateTimeCreated: Date(), isGood: true),
            Dot(dateTimeCreated: Date(), isGood: false),
            Dot(dateTimeCreated: Date(), isGood: true, text: "Some Description goes here and it is longer than one line"),
        ])
    }
}
