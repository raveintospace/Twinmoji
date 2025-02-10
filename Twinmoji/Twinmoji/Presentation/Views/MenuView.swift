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
            GameView(viewModel: viewModel)
        } else {
            VStack(spacing: 6) {
                twinmojiTitle
                emojisDeckTitle
                emojisDeckPicker
                answerTimeTitle
                answerTimePicker
                difficultyTitle
                difficultyPicker
                menuButtons
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

extension MenuView {
    
    private var twinmojiTitle: some View {
        Text("Twinmoji")
            .font(.largeTitle)
            .bold()
            .fontDesign(.rounded)
    }
    
    private var emojisDeckTitle: some View {
        Text("Emojis deck")
            .font(.headline)
    }
    
    private var emojisDeckPicker: some View {
        Picker("Emojis deck", selection: $viewModel.emojisDeck) {
            Text("Animals").tag(Deck.animals)
            Text("Faces").tag(Deck.faces)
            Text("Flags").tag(Deck.flags)
            Text("Food").tag(Deck.food)
        }
        .pickerStyle(.segmented)
        .padding(.bottom)
    }
    
    private var answerTimeTitle: some View {
        Text("Answer time")
            .font(.headline)
    }
    
    private var answerTimePicker: some View {
        Picker("Timeout", selection: $viewModel.answerTime) {
            Text("Slow").tag(2.0)
            Text("Medium").tag(1.0)
            Text("Fast").tag(0.5)
        }
        .pickerStyle(.segmented)
        .padding(.bottom)
    }
    
    private var difficultyTitle: some View {
        Text("Difficulty")
            .font(.headline)
    }
    
    private var difficultyPicker: some View {
        Picker("Difficulty", selection: $viewModel.itemCount) {
            Text("Easy").tag(9)
            Text("Hard").tag(12)
        }
        .pickerStyle(.segmented)
        .padding(.bottom)
    }
    
    private var menuButtons: some View {
        HStack(spacing: 10) {
            Button("How to play") {
                // show modal
            }
            .background(.blue)
            
            Button("Start game") {
                viewModel.isGameActive = true
            }
            .background(.green)
        }
        .buttonStyle(.bordered)
        .foregroundStyle(.white)
        .clipShape(.rect(cornerRadius: 30))
    }
}
