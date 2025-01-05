//
//  ContentView.swift
//  Twinmoji
//
//  Created by Uri on 5/1/25.
//

import SwiftUI

struct ContentView: View {
    
    let allEmoji = Array("emoji").map(String.init)
    
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
    ContentView()
}
