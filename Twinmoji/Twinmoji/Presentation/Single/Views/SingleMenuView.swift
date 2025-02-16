//
//  SingleMenuView.swift
//  Twinmoji
//
//  Created by Uri on 15/2/25.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case rules
    case scoreboard
    
    var id: Int {
        hashValue
    }
}

struct SingleMenuView: View {
    
    @StateObject private var viewModel = SingleViewModel()
    
    @State private var activeSheet: ActiveSheet?
    
    var body: some View {
        if viewModel.isGameActive {
            SingleGameView(viewModel: viewModel)
        } else {
            VStack(spacing: 6) {
                singleMenuToolBar
                emojisDeckTitle
                emojisDeckPicker
                answerTimeTitle
                answerTimePicker
                difficultyTitle
                difficultyPicker
                menuButtons
            }
            .padding()
            .foregroundStyle(.black)
            .background(.white)
            .clipShape(.rect(cornerRadius: 20))
            .shadow(radius: 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(TwinmojiGradient())
            .sheet(item: $activeSheet) { sheet in
                switch sheet {
                case .rules:
                    SingleRulesView()
                case .scoreboard:
                    SingleScorecardView()
                }
            }
            .toolbarVisibility(.hidden, for: .navigationBar)
        }
    }
}

#if DEBUG
#Preview {
    SingleMenuView()
}
#endif

extension SingleMenuView {
    
    private var twinmojiTitle: some View {
        Text("Twinmoji - Single mode")
            .font(.largeTitle)
            .bold()
            .fontDesign(.rounded)
    }
    
    private var singleMenuToolBar: some View {
        HStack(spacing: 0) {
            GoToHomeViewButton()
                .frame(width: 12, alignment: .leading)
            twinmojiTitle
                .frame(maxWidth: .infinity, alignment: .center)
        }
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
            Text("Slow").tag(5.0)
            Text("Medium").tag(2.5)
            Text("Fast").tag(1.5)
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
            Button("Single rules") {
                activeSheet = .rules
            }
            .background(.blue)
            
            Button("Scoreboard") {
                activeSheet = .scoreboard
            }
            .background(.purple)
            
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
