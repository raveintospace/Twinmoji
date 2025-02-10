//
//  ContentView.swift
//  Twinmoji
//  https://www.youtube.com/live/up6LpJOz5bQ?si=sOrtjm8f7elYvGO_
//  Created by Uri on 5/1/25
//

import SwiftUI

struct GameView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var activeAlert: GameAlert? = nil
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            gameSpace
            exitGameButton
            playerTurnTitle
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.orange)
        .persistentSystemOverlays(.hidden)
        .onAppear {
            viewModel.createLevel()
        }
        .alert(item: $activeAlert) {
            alertType in
            switch alertType {
            case .playerHasWon:
                return gameOverAlert()
            case .resetGame:
                return exitGameAlert()
            }
        }
        .onChange(of: viewModel.playerHasWon) { _ , newValue in
            if newValue {
                activeAlert = .playerHasWon
            }
        }
    }
}

#if DEBUG
#Preview {
    GameView(viewModel: ViewModel())
}
#endif

extension GameView {
    private var gameSpace: some View {
        HStack(spacing: 0) {
            playerOneButton
            
            ZStack {
                viewModel.answerColor
                    .scaleEffect(x: viewModel.answerScale, anchor: viewModel.answerAnchor)
                
                if viewModel.leftCard.isEmpty == false {
                    playerCards
                }
            }
            
            playerTwoButton
        }
    }
    
    private var playerCards: some View {
        HStack {
            CardView(
                card: viewModel.leftCard,
                userCanAnswer: viewModel.gameState != .waiting,
                onSelect: { selectedEmoji in
                    viewModel.checkAnswer(selectedEmoji: selectedEmoji)
                })
            
            CardView(card: viewModel.rightCard,
                     userCanAnswer: viewModel.gameState != .waiting,
                     onSelect: { selectedEmoji in
                viewModel.checkAnswer(selectedEmoji: selectedEmoji)
            })
        }
        .padding(.horizontal, 10)
    }
    
    private var playerOneButton: some View {
        PlayerButton(
            gameState: viewModel.gameState,
            playerNumber: "1",
            score: viewModel.player1Score,
            color: viewModel.gameTurn == .player2 ? .blue : .black,
            onButtonPressed: viewModel.selectPlayer2
        )
        .disabled(viewModel.gameTurn != .player2)
    }
    
    private var playerTwoButton: some View {
        PlayerButton(
            gameState: viewModel.gameState,
            playerNumber: "2",
            score: viewModel.player2Score,
            color: viewModel.gameTurn == .player1 ? .red : .black,
            onButtonPressed: viewModel.selectPlayer1
        )
        .disabled(viewModel.gameTurn != .player1)
    }
    
    private var exitGameButton: some View {
        Button("Exit game", systemImage: "xmark.circle") {
            activeAlert = .resetGame
        }
        .symbolVariant(.fill)
        .labelStyle(.iconOnly)
        .font(.largeTitle)
        .tint(.white)
        .padding(40)
    }
    
    private var playerTurnTitle: some View {
        Text(viewModel.gameTurn.rawValue)
            .foregroundStyle(.white)
            .font(.system(size: 24))
            .bold()
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
    }
    
    private func gameOverAlert() -> Alert {
        let winnerMessage: String
        if viewModel.player1Score > viewModel.player2Score {
            winnerMessage = "Player 1 won \(viewModel.player1Score) - \(viewModel.player2Score)"
        } else {
            winnerMessage = "Player 2 won \(viewModel.player1Score) - \(viewModel.player2Score)"
        }
        
        return Alert(
            title: Text("Game over!"),
            message: Text(winnerMessage),
            dismissButton: .default(Text("Start again")) {
                viewModel.exitGame()
            }
        )
    }
    
    private func exitGameAlert() -> Alert {
        return Alert(
            title: Text("Exit game?"),
            message: Text("Are you sure you want to exit the game?"),
            primaryButton: .default(Text("Exit")) {
                viewModel.exitGame()
            },
            secondaryButton: .destructive(Text("Cancel"))
        )
    }
}
