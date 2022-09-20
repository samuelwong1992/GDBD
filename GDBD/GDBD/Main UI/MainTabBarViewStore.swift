//
//  MainTabBarViewStore.swift
//  GDBD
//
//  Created by Samuel Wong on 16/9/2022.
//

import SwiftUI

enum AppState {
    case Calendar
    case Stats
}

class MainTabBarViewStore: ObservableObject {
    @Published var selectedDate: Date = Date()
    @Published var currentState: AppState = .Stats
}
