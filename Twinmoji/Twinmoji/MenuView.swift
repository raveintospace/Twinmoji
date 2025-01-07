//
//  MenuView.swift
//  Twinmoji
//
//  Created by Uri on 7/1/25.
//

import SwiftUI

struct MenuView: View {
    
    @State private var answerTime: Double = 1.0
    @State private var items: Int = 9
    @State private var isGameActive: Bool = false
    
    var body: some View {
        if isGameActive {
            ContentView(answerTime: answerTime, itemCount: items, isGameActive: $isGameActive)
        } else {
            VStack(spacing: 10) {
                Text("Twinmoji")
                    .font(.largeTitle)
                    .bold()
                    .fontDesign(.rounded)
                
                Text("Answer time")
                    .font(.headline)
                
                Picker("Timeout", selection: $answerTime) {
                    Text("Slow").tag(2.0)
                    Text("Medium").tag(1.0)
                    Text("Fast").tag(0.5)
                }
                .pickerStyle(.segmented)
                .padding(.bottom)
                
                Text("Difficulty")
                    .font(.headline)
                
                Picker("Difficulty", selection: $items) {
                    Text("Easy").tag(9)
                    Text("Hard").tag(12)
                }
                .pickerStyle(.segmented)
                .padding(.bottom)
                
                Button("Start game") {
                    isGameActive = true
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .background(.white)
            .clipShape(.rect(cornerRadius: 20))
            .shadow(radius: 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(.orange)
        }
    }
}

#Preview {
    MenuView()
}
