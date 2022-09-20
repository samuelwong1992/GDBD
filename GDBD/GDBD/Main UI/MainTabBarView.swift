//
//  MainTabBarView.swift
//  GDBD
//
//  Created by Samuel Wong on 12/8/2022.
//

import SwiftUI

struct MainTabBarView: View {
    @ObservedObject var viewStore: MainTabBarViewStore = MainTabBarViewStore()
    
//    @State var selectedDate: Date = Date()
    var storageService: DotService
    
    var body: some View {
        VStack(spacing: 0) {
            NewDotView()
                .foregroundColor(Color.white)
            
            switch viewStore.currentState {
            case .Calendar :
                CalendarView(viewStore: CalendarViewStore(storageService: storageService, date: $viewStore.selectedDate))
                    .padding(.top)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(RoundedCornerView(tl: 40, tr: 40, bl: 0, br: 0).fill(Color(UIColor.systemBackground)))
            case .Stats :
                StatsView(viewStore: StatsViewViewStore(date: $viewStore.selectedDate))
                    .padding(.top)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(RoundedCornerView(tl: 40, tr: 40, bl: 0, br: 0).fill(Color(UIColor.systemBackground)))
            }
            
            HStack {
                TabBarButton(systemImageName: "calendar", title: "Calendar") {
                    viewStore.currentState = .Calendar
                }
                
                TabBarButton(systemImageName: "chart.xyaxis.line", title: "Stats") {
                    viewStore.currentState = .Stats
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
        Group {
            MainTabBarView(storageService: DotCoreDataService(persistenceController: PersistenceController.preview))
            
            MainTabBarView(storageService: DotCoreDataService(persistenceController: PersistenceController.preview)).preferredColorScheme(.dark)
        }
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
