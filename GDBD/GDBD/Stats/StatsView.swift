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
    
    @State var viewStore1: GraphViewViewStore
    
    init(viewStore: StatsViewViewStore) {
        self.viewStore = viewStore
        
        self.viewStore1 = GraphViewViewStore(title: "Graph 1a", percentage: 0.4)
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                MonthDatePicker(date: $viewStore.date)
            }
            .padding(.bottom)
            
            HStack {
                GraphView(viewStore: viewStore1)
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

class GraphViewViewStore: ObservableObject {
    var title: String
    @Published var percentage: Double {
        didSet {
            withAnimation(Animation.easeInOut(duration: 1.0)) {
                self.animatableDegrees = percentage * 360
            }
        }
    }
    @Published var animatableDegrees: Double = 0
    
    init(title: String, percentage: Double) {
        self.title = title
        self.percentage = 0
        
        defer {
            self.percentage = percentage
        }
    }
}

struct GraphView: View {
    @ObservedObject private var viewStore: GraphViewViewStore
    
    init(viewStore: GraphViewViewStore) {
        self.viewStore = viewStore
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let halfWidth = geometry.size.width * 0.5
                
                Path { path in
                    path.addArc(center: CGPoint(x: halfWidth, y: halfWidth), radius: halfWidth - 6, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
                }
                .stroke(.red, lineWidth: 20)
                
                AnimatableCircle(degrees: viewStore.animatableDegrees)
                    .stroke(.blue, lineWidth: 12)
                
                VStack {
                    Text("\(Int(viewStore.percentage*100))%")
                    Text(viewStore.title)
                }
                .onTapGesture {
                    viewStore.percentage += 0.1
                }
            }
            .frame(height: geometry.size.width)
        }
    }
}

struct AnimatableCircle: Shape {
    var degrees: Double
    var animatableData: Double {
        get {
            return degrees
        }
        set {
            degrees = newValue
        }
    }
    
    init(degrees: Double) {
        self.degrees = degrees
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.width/2, y: rect.width/2), radius: rect.width/2 - 6, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 270+animatableData), clockwise: false)
        
        return path
    }
    
    
}
