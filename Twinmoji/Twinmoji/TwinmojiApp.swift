//
//  TwinmojiApp.swift
//  Twinmoji
//
//  Created by Uri on 5/1/25.
//

import SwiftUI

@main
struct TwinmojiApp: App {
    var body: some Scene {
        WindowGroup {
            MenuView()
                .preferredColorScheme(.light)       // forces light mode
        }
    }
}
