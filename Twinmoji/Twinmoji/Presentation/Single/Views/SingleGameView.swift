//
//  SingleGameView.swift
//  Twinmoji
//
//  Created by Uri on 15/2/25.
//

import SwiftUI

struct SingleGameView: View {
    
    @ObservedObject var viewModel: SingleViewModel
    
    @State private var activeAlert: SingleGameAlert? = nil
    
    @State private var countdownTime: Double = 5.0
    
    @State private var showSingleScoreForm: Bool = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            gameSpace
            exitGameButton
            timeLeftText
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(TwinmojiGradient())
        .persistentSystemOverlays(.hidden)
        .toolbarVisibility(.hidden, for: .navigationBar)
        .onAppear {
            setupView()
        }
        .alert(item: $activeAlert) {
            alertType in
            switch alertType {
            case .hasGameEnded:
                return gameEndedAlert()
            case .resetGame:
                return exitGameAlert()
            }
        }
        .sheet(isPresented: $showSingleScoreForm) {
            SingleScoreForm(viewModel: viewModel)
                .preferredColorScheme(.light)
                .onDisappear {
                    // offer play again or exit
                }
        }
        .onChange(of: viewModel.hasGameEnded) { _ , newValue in
            if newValue {
                activeAlert = .hasGameEnded
            }
        }
    }
}

#if DEBUG
#Preview {
    SingleGameView(viewModel: SingleViewModel())
}
#endif

extension SingleGameView {
    
    private var gameSpace: some View {
        HStack(spacing: 0) {
            scoreAndMatchesRectangle
            
            ZStack {
                if viewModel.leftCard.isEmpty == false {
                    playerCards
                }
                countdownText
            }
            
            roundsRectangle
        }
    }
    
    private var scoreAndMatchesRectangle: some View {
        Rectangle()
            .fill(.clear)
            .frame(minWidth: 30)
            .overlay(
                VStack(alignment: .center) {
                    Text("Score:")
                    Text(String(viewModel.playerScore))
                    Divider()
                    Text("Matches:")
                    Text(String(viewModel.matches))
                }
                    .fixedSize()
                    .font(.system(size: 22))
                    .foregroundStyle(.white)
                    .bold()
            )
    }
    
    private var roundsRectangle: some View {
        Rectangle()
            .fill(.clear)
            .frame(minWidth: 30)
            .overlay(
                VStack(alignment: .center) {
                    Text("Rounds:")
                    Text("\(viewModel.rounds) / \(viewModel.roundsToPlay)")
                }
                    .fixedSize()
                    .font(.system(size: 22))
                    .foregroundStyle(.white)
                    .bold()
            )
    }
    
    private var playerCards: some View {
        HStack {
            CardView(
                card: viewModel.leftCard,
                userCanAnswer: viewModel.userCanAnswer(),
                onSelect: { selectedEmoji in
                    viewModel.checkAnswer(selectedEmoji: selectedEmoji)
                })
            
            CardView(card: viewModel.rightCard,
                     userCanAnswer: viewModel.userCanAnswer(),
                     onSelect: { selectedEmoji in
                viewModel.checkAnswer(selectedEmoji: selectedEmoji)
            })
        }
        .padding(.horizontal, 10)
        .opacity(viewModel.showPlayerCards ? 1 : 0)
        .disabled(!viewModel.showPlayerCards)
    }
    
    private var timeLeftText: some View {
        Text("Time left: \(String(format: "%.2f", viewModel.timeRemaining))")
            .foregroundStyle(.white)
            .font(.system(size: viewModel.itemCount == 12 ? 12 : 24))
            .bold()
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 10)
    }
    
    private var countdownText: some View {
        Text("\(String(format: "%.0f", countdownTime))")
            .foregroundStyle(.white)
            .font(.system(size: 100))
            .bold()
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
            .opacity(countdownTime > 0 ? 1 : 0)
    }

    
    private var exitGameButton: some View {
        Button("Exit game", systemImage: "xmark.circle") {
            withAnimation {
                viewModel.pauseGame()
                viewModel.showPlayerCards = false
                activeAlert = .resetGame
            }
        }
        .symbolVariant(.fill)
        .labelStyle(.iconOnly)
        .font(.largeTitle)
        .tint(.white)
        .padding(40)
        .opacity(viewModel.showPlayerCards ? 1 : 0)
        .disabled(!viewModel.showPlayerCards)
    }
    
    private func exitGameAlert() -> Alert {
        return Alert(
            title: Text("Exit game?"),
            message: Text("Are you sure you want to exit the game?"),
            primaryButton: .destructive(Text("Exit")) {
                viewModel.exitGame()
            },
            secondaryButton: .default(Text("Cancel")) {
                viewModel.showPlayerCards = true
                viewModel.resumeGame()
            }
        )
    }
    
    private func gameEndedAlert() -> Alert {
        if !viewModel.isScoreboardFull() && viewModel.isNewHighScore(score: viewModel.playerScore) {
            return Alert(
                title: Text("Game ended with a new high score!"),
                message: Text("Final score: \(viewModel.playerScore)"),
                primaryButton: .default(Text("Save score")) {
                    showSingleScoreForm = true
                },
                secondaryButton: .destructive(Text("Start again")) {
                    viewModel.exitGame()
                }
            )
        } else {
            return Alert(
                title: Text("Game ended!"),
                message: Text("Final score: \(viewModel.playerScore)"),
                dismissButton: .default(Text("Start again")) {
                    viewModel.exitGame()
                }
            )
        }
    }
    
    private func startCountdownToActivateGame() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
            withAnimation {
                viewModel.showPlayerCards = true
            }
            viewModel.activateSinglePlayer()
        }
    }
    
    private func startCountdownAnimation() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if countdownTime > 0 {
                countdownTime -= 1
            } else {
                timer.invalidate()
            }
        }
    }
    
    private func setupView() {
        viewModel.createLevel()
        startCountdownToActivateGame()
        startCountdownAnimation()
    }
}
