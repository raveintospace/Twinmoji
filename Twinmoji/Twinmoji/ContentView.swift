//
//  ContentView.swift
//  Twinmoji
//  https://www.youtube.com/live/up6LpJOz5bQ?si=sOrtjm8f7elYvGO_
//  Created by Uri on 5/1/25
//

import SwiftUI

struct ContentView: View {
    
    // viewmodel refactor
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            gameSpace
            endGameButton
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.orange)
        .persistentSystemOverlays(.hidden)
        .onAppear {
            viewModel.createLevel()
        }
        .alert(isPresented: $viewModel.playerHasWon) {
            gameOverAlert()
        }
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
}

extension ContentView {
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
        PlayerButton(gameState: viewModel.gameState, score: viewModel.player1Score, color: .blue, onButtonPressed: viewModel.selectPlayer1)
    }
    
    private var playerTwoButton: some View {
        PlayerButton(gameState: viewModel.gameState, score: viewModel.player2Score, color: .red, onButtonPressed: viewModel.selectPlayer2)
    }
    
    private var endGameButton: some View {
        Button("End game", systemImage: "xmark.circle") {
            viewModel.isGameActive = false
        }
        .symbolVariant(.fill)
        .labelStyle(.iconOnly)
        .font(.largeTitle)
        .tint(.white)
        .padding(40)
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
                viewModel.startAgain()
            }
        )
    }
}
