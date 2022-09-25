//
//  StatsView.swift
//  GDBD
//
//  Created by Samuel Wong on 16/9/2022.
//

import SwiftUI

class StatsViewViewStore: ObservableObject {
    @Binding var date: Date
    
    init(date: Binding<Date>) {
        self._date = date
    }
}

struct StatsView: View {
    
    @ObservedObject private var viewStore: StatsViewViewStore
    
    @State var perc1: Double = 6
    @State var perc2: Double = 3
    
    @State var maxValue: Double = 10
    
    init(viewStore: StatsViewViewStore) {
        self.viewStore = viewStore
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                MonthDatePicker(date: $viewStore.date)
            }
            .padding(.bottom)
            
            HStack {
                CircularGraphView(viewStore: CircularGraphViewViewStore(
                    title: "Graph 1",
                    color: .red,
                    datas: [
                        (currentValue: $perc1, maxValue: $maxValue, color: .yellow, title: "Part 1"),
                        (currentValue: $perc2, maxValue: $maxValue, color: .green, title: "Part 2")
                    ])
                )
                .padding()
                
            }
        }.padding()
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(viewStore: StatsViewViewStore(date: .constant(Date())))
    }
}
