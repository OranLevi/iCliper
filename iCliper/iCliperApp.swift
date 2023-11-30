//
//  iCliperApp.swift
//  iCliper
//
//  Created by Oran Levi on 26/11/2023.
//

import SwiftUI
import SwiftData

@main
struct iCliperApp: App {
    
    @State private var selectionTab = 0
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectionTab){
                ClipBoardView()
                    .tabItem {
                        Label(String(localized: "iCliperApp_TabView_Clipboard"), systemImage: "square.and.pencil")
                    }.tag(0)
                SettingView()
                    .tabItem {
                        Label(String(localized: "iCliperApp_TabView_Setting"), systemImage: "gear.circle")
                    }.tag(1)
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
