//
//  GDBDApp.swift
//  GDBD
//
//  Created by Samuel Wong on 12/8/2022.
//

import SwiftUI

@main
struct GDBDApp: App {

    var body: some Scene {
        WindowGroup {
            MainTabBarView(storageService: DotCoreDataService())
        }
    }
}
