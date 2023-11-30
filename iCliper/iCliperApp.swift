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
    
    var body: some Scene {
        WindowGroup {
            TabView(){
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
