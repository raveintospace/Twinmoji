//
//  TwinmojiApp.swift
//  Twinmoji
//
//  Created by Uri on 5/1/25.
//

import SwiftUI

@main
struct TwinmojiApp: App {
    
    @State private var showSplashView: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                HomeView()
                    .preferredColorScheme(.light)       // forces light mode
                
                SplashView(showSplashView: $showSplashView)
                    .opacity(showSplashView ? 1 : 0)
            }
        }
    }
}
