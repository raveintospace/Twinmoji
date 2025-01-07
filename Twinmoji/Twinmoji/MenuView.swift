//
//  MenuView.swift
//  Twinmoji
//
//  Created by Uri on 7/1/25.
//

import SwiftUI

struct MenuView: View {
    
    @State private var timeOut: Double = 1.0
    @State private var items: Int = 9
    @State private var isGameActive: Bool = false
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MenuView()
}
