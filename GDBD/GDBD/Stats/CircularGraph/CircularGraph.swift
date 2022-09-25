//
//  CircularGraph.swift
//  GDBD
//
//  Created by Samuel Wong on 24/9/2022.
//

import SwiftUI

typealias CircularGraphData = (currentValue: Binding<Double>, maxValue: Binding<Double>, color: Color, title: String)

private class CircularGraphAnimatableData: ObservableObject {
    var color: Color
    var title: String
    
    @Binding var currentValue: Double
    @Binding var maxValue: Double
    @Published var animatableDegrees: Double = 0
    
    var percentage: Double {
        return currentValue/maxValue
    }
        
    init(currentValue: Binding<Double>, maxValue: Binding<Double>, color: Color, title: String) {
        self._currentValue = currentValue
        self._maxValue = maxValue
        self.color = color
        self.title = title
        
        defer {
            self.animatableDegrees = self.percentage*360
        }
    }
}

class CircularGraphViewViewStore: ObservableObject {
    var title: String
    var color: Color
    @Published var selectedIndex: Int?
    @Published fileprivate var datas: [CircularGraphAnimatableData]
    
    init(title: String, color: Color, datas: [CircularGraphData]) {
        self.title = title
        self.datas = datas.map({ CircularGraphAnimatableData(currentValue: $0.currentValue, maxValue: $0.maxValue, color: $0.color, title: $0.title) })
        self.color = color
        
    }
}

struct CircularGraphView: View {
    @ObservedObject private var viewStore: CircularGraphViewViewStore
    
    init(viewStore: CircularGraphViewViewStore) {
        self.viewStore = viewStore
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let halfWidth = geometry.size.width * 0.5
                
                Path { path in
                    path.addArc(center: CGPoint(x: halfWidth, y: halfWidth), radius: halfWidth - 6, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
                }
                .stroke(viewStore.color, lineWidth: 20)
                
                ForEach(0 ..< viewStore.datas.count, id: \.self) { i in
                    let data = viewStore.datas[i]
                    AnimatableCircle(degrees: data.animatableDegrees)
                        .stroke(data.color, style: StrokeStyle(lineWidth: viewStore.selectedIndex == i ? 24 : 20, lineCap: CGLineCap.square))
                        .onTapGesture {
                            viewStore.selectedIndex = viewStore.selectedIndex != i ? i : nil
                        }
                        .padding(CGFloat(i)*20.0)
                }
                
                VStack {
                    if let selectedIndex = viewStore.selectedIndex {
                        Text("\(Int(viewStore.datas[selectedIndex].percentage*100))%")
                        Text("\(Int(viewStore.datas[selectedIndex].currentValue)) / \(Int(viewStore.datas[selectedIndex].maxValue))")
                        Text(viewStore.datas[selectedIndex].title)
                    } else {
                        Text(viewStore.title)
                    }
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
