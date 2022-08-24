//
//  MainTabBarView.swift
//  GDBD
//
//  Created by Samuel Wong on 12/8/2022.
//

import SwiftUI

struct MainTabBarView: View {
    var body: some View {
        VStack(spacing: 0) {
            NewDotView()
                .foregroundColor(Color.white)
            
            CalendarView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(RoundedCornerView(tl: 40, tr: 40, bl: 0, br: 0).fill(Color(UIColor.systemBackground)))
            
            HStack {
                TabBarButton(systemImageName: "calendar", title: "Calendar") {
                    print("on calendar pressed")
                }
                
                TabBarButton(systemImageName: "chart.xyaxis.line", title: "Progress") {
                    print("on progress pressed")
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .foregroundColor(Color.primary)
            .background(Color(UIColor.systemBackground))
            
            
        }.background(Color.midnightGray)
            
    }
}

struct MainTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarView()
        
        MainTabBarView().preferredColorScheme(.dark)
    }
}

struct TabBarButton: View {
    let systemImageName: String
    let title: String
    let onPress: (() -> Void)
    
    var body: some View {
        Button {
            onPress()
        } label: {
            VStack {
                Image(systemName: systemImageName)
                Text(title)
            }
        }
    }
}
