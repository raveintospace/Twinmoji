//
//  ContentView.swift
//  Twinmoji
//  https://www.youtube.com/live/up6LpJOz5bQ?si=sOrtjm8f7elYvGO_
//  Created by Uri on 5/1/25.
//

import SwiftUI

struct ContentView: View {
    
    // creates an array of characters
    let allEmoji = Array("😎🥹🥰😔😂😳🧐🙂😇😅😆😙😬🙃😍🥸😣😶🙄🤨😩😉🥲😋😛🤓😏😭😯😵😐😘😢😠").map(String.init)
    
    @State private var currentEmoji: [String] = []
    
    @State private var leftCard: [String] = []
    @State private var rightCard: [String] = []
    
    var itemCount: Int
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView(itemCount: 9)
}


