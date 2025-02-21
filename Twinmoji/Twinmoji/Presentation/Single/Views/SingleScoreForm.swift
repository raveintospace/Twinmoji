//
//  SingleScoreForm.swift
//  Twinmoji
//
//  Created by Uri on 17/2/25.
//


import SwiftUI

struct SingleScoreForm: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: SingleViewModel
    
    @State private var playerName: String = ""
    @FocusState private var playerNameFocused: Bool
    
    @State private var showDismissAlert: Bool = false
    
    private let textFieldMaxLength: Int = 8
    
    var body: some View {
        NavigationStack {
            ZStack {
                TwinmojiGradient()
                
                Form {
                    playerNameSection
                    deckPlayedSection
                    totalMatchesSection
                    finalScoreSection
                    saveScoreButtonSection
                }
                .padding()
                .foregroundStyle(.black)
                .background(.white)
                .clipShape(.rect(cornerRadius: 20))
                .shadow(radius: 10)
                .onAppear {
                    playerNameFocused = true
                }
                .alert(isPresented: $showDismissAlert) {
                    Alert(
                        title: Text("Exit screen"),
                        message: Text("You will lose your score if you press Exit"),
                        primaryButton: .destructive(Text("Exit")) { exitToMainMenu() },
                        secondaryButton: .default(Text("Keep editing"))
                    )
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    singleScoreFormTitle
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    exitScoreFormButton
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    SingleScoreForm(viewModel: SingleViewModel())
}
#endif

extension SingleScoreForm {
    
    private var exitScoreFormButton: some View {
        Button("Exit game", systemImage: "xmark.circle") {
            showDismissAlert = true
        }
        .symbolVariant(.fill)
        .labelStyle(.iconOnly)
        .font(.largeTitle)
        .tint(.white)
    }
    
    private var singleScoreFormTitle: some View {
        Text("Save your score")
            .font(.title2)
            .bold()
            .foregroundColor(.white)
    }
    
    private var playerNameSection: some View {
        Section(header: Text("Player name")) {
            TextField("Player name", text: $playerName)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.words)
                .focused($playerNameFocused)
                .submitLabel(.done)
                .keyboardType(.alphabet)
                .onChange(of: playerName) { _, newValue in
                    playerName = newValue.filter { $0.isLetter || $0.isNumber }
                    
                    if playerName.count > textFieldMaxLength { playerName = String(playerName.prefix(textFieldMaxLength))
                    }
                }
        }
    }
    
    private var deckPlayedSection: some View {
        Section(header: Text("Deck played")) {
            Text("\(viewModel.emojisDeck.rawValue)")
        }
    }
    
    private var totalMatchesSection: some View {
        Section(header: Text("Total matches")) {
            Text("\(viewModel.matches)")
        }
    }
    
    private var finalScoreSection: some View {
        Section(header: Text("Final score")
            .bold()
            .font(.title)
        ) {
            Text("\(viewModel.playerScore)")
                .bold()
                .font(.largeTitle)
        }
    }
    
    private var saveScoreButtonSection: some View {
        Section {
            Button("Save score") {
                saveScore()
                exitToMainMenu()
            }
            .foregroundStyle(.blue)
            .disabled(playerName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
    }
    
    private func saveScore() {
        viewModel.saveScore(player: playerName, deck: viewModel.emojisDeck.rawValue, matches: viewModel.matches, score: viewModel.playerScore)
    }
    
    private func exitToMainMenu() {
        viewModel.exitGame()
    }
}
