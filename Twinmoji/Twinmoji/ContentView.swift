//
//  ContentView.swift
//  Twinmoji
//  https://www.youtube.com/live/up6LpJOz5bQ?si=sOrtjm8f7elYvGO_
//  Created by Uri on 5/1/25
//

import SwiftUI

struct ContentView: View {
    
    // creates an array of characters
//    let allEmoji = Array("😎🥹🥰😔😂😳🧐🙂😇😅😆😙😬🙃😍🥸😣😶🙄🤨😩😉🥲😋😛🤓😏😭😯😵😐😘😢😠").map(String.init)
//    
//    @State private var currentEmoji: [String] = []
//    
//    @State private var leftCard: [String] = []
//    @State private var rightCard: [String] = []
//    
//    @State private var gameState: GameState = GameState.waiting
//    
//    @State private var player1Score: Int = 0
//    @State private var player2Score: Int = 0
//    
//    @State private var answerColor: Color = .clear
//    @State private var answerScale: CGFloat = 1.0
//    @State private var answerAnchor: UnitPoint = .center
//    
//    @State private var playerHasWon: Bool = false
    
    // Properties passed from MenuView
    var answerTime: Double
    var itemCount: Int
    @Binding var isGameActive: Bool
    
    // viewmodel refactor
    @State var viewModel = ContentViewModel()
    
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
            createLevel()
        }
        .alert(isPresented: $viewModel.playerHasWon) {
            gameOverAlert()
        }
    }
}

#Preview {
    ContentView(answerTime: 1, itemCount: 9, isGameActive: .constant(true))
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
                    checkAnswer(selectedEmoji: selectedEmoji)
                })
            
            CardView(card: viewModel.rightCard,
                     userCanAnswer: viewModel.gameState != .waiting,
                     onSelect: { selectedEmoji in
                checkAnswer(selectedEmoji: selectedEmoji)
            })
        }
        .padding(.horizontal, 10)
    }
    
    private var playerOneButton: some View {
        PlayerButton(gameState: viewModel.gameState, score: viewModel.player1Score, color: .blue, onButtonPressed: selectPlayer1)
    }
    
    private var playerTwoButton: some View {
        PlayerButton(gameState: viewModel.gameState, score: viewModel.player2Score, color: .red, onButtonPressed: selectPlayer2)
    }
    
    private var endGameButton: some View {
        Button("End game", systemImage: "xmark.circle") {
            isGameActive = false
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
                isGameActive = false
            }
        )
    }
    
    private func createLevel() {
        viewModel.currentEmoji = viewModel.allEmoji.shuffled()
        
        withAnimation(.spring(duration: 0.75)) {
            viewModel.leftCard = Array(viewModel.currentEmoji[0..<itemCount]).shuffled()
            
            // create an array with only one duplicated emoji (currentEmoji[0])
            viewModel.rightCard = Array(viewModel.currentEmoji[itemCount + 1..<itemCount + itemCount] + [viewModel.currentEmoji[0]].shuffled())
        }
    }
    
    private func selectPlayer1() {
        guard viewModel.gameState == .waiting else { return }
        viewModel.answerColor = .blue
        viewModel.answerAnchor = .leading
        viewModel.gameState = .player1Answering
        runClock()
    }
    
    private func selectPlayer2() {
        guard viewModel.gameState == .waiting else { return }
        viewModel.answerColor = .red
        viewModel.answerAnchor = .trailing
        viewModel.gameState = .player2Answering
        runClock()
    }
    
    private func timeOut(emojiToCheck: [String]) {
        guard viewModel.currentEmoji == emojiToCheck else { return } // avoids timming out if the cardView has changed
        
        
        if viewModel.gameState == .player1Answering {
            viewModel.player1Score -= 1
        } else if viewModel.gameState == .player2Answering {
            viewModel.player2Score -= 1
        }
        
        viewModel.gameState = .waiting
    }
    
    private func runClock() {
        viewModel.answerScale = 1
        let checkEmoji = viewModel.currentEmoji
        
        withAnimation(.linear(duration: answerTime)) {
            viewModel.answerScale = 0
        } completion: {
            timeOut(emojiToCheck: checkEmoji)
        }
    }
    
    private func checkAnswer(selectedEmoji: String) {
        if selectedEmoji == viewModel.currentEmoji[0] {       // right answer
            if viewModel.gameState == .player1Answering {
                viewModel.player1Score += 1
            } else if viewModel.gameState == .player2Answering {
                viewModel.player2Score += 1
            }
            
            if viewModel.player1Score == 5 || viewModel.player2Score == 5 {
                viewModel.playerHasWon = true
            } else {
                createLevel()
            }
        } else {    // wrong answer
            if viewModel.gameState == .player1Answering {
                viewModel.player1Score -= 1
            } else if viewModel.gameState == .player2Answering {
                viewModel.player2Score -= 1
            }
        }
        
        viewModel.answerColor = .clear
        viewModel.answerScale = 0
        viewModel.gameState = .waiting
    }
}
