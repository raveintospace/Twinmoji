//
//  MenuView.swift
//  Twinmoji
//
//  Created by Uri on 7/1/25.
//

import SwiftUI

struct MenuView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isGameActive {
            ContentView(viewModel: viewModel)
        } else {
            VStack(spacing: 10) {
                Text("Twinmoji")
                    .font(.largeTitle)
                    .bold()
                    .fontDesign(.rounded)
                
                Text("Emojis deck")
                    .font(.headline)
                
                Picker("Emojis deck", selection: $viewModel.emojisDeck) {
                    Text("Animals").tag(Deck.animals)
                    Text("Faces").tag(Deck.faces)
                    Text("Flags").tag(Deck.flags)
                    Text("Food").tag(Deck.food)
                }
                .pickerStyle(.segmented)
                .padding(.bottom)
                
                Text("Answer time")
                    .font(.headline)
                
                Picker("Timeout", selection: $viewModel.answerTime) {
                    Text("Slow").tag(2.0)
                    Text("Medium").tag(1.0)
                    Text("Fast").tag(0.5)
                }
                .pickerStyle(.segmented)
                .padding(.bottom)
                
                Text("Difficulty")
                    .font(.headline)
                
                Picker("Difficulty", selection: $viewModel.itemCount) {
                    Text("Easy").tag(9)
                    Text("Hard").tag(12)
                }
                .pickerStyle(.segmented)
                .padding(.bottom)
                
                Button("Start game") {
                    viewModel.isGameActive = true
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
