//
//  ContentView.swift
//  Twinmoji
//  https://www.youtube.com/live/up6LpJOz5bQ?si=sOrtjm8f7elYvGO_
//  Created by Uri on 5/1/25.
//

import SwiftUI

struct ContentView: View {
    
    // creates an array of characters
    let allEmoji = Array("😎🥹🥰😔😂😳🧐🙂😇😅😆😙😬🙃😍🥸😣😶🙄🤨😩😉🥲😋😛🤓😏😭😯😵😐😘😢😠").map(String.init)
    
    @State private var currentEmoji: [String] = []
    
    @State private var leftCard: [String] = []
    @State private var rightCard: [String] = []
    
    @State private var gameState: GameState = GameState.waiting
    
    @State private var player1Score: Int = 0
    @State private var player2Score: Int = 0
    
    @State private var answerColor: Color = .clear
    @State private var answerScale: CGFloat = 1.0
    @State private var answerAnchor: UnitPoint = .center
    
    @State private var playerHasWon: Bool = false
    
    // Properties passed from MenuView
    var answerTime: Double
    var itemCount: Int
    @Binding var isGameActive: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            PlayerButton(gameState: gameState, score: player1Score, color: .blue, onButtonPressed: selectPlayer1)
            
            ZStack {
                answerColor
                    .scaleEffect(x: answerScale, anchor: answerAnchor)
                
                if leftCard.isEmpty == false {
                    HStack {
                        CardView(
                            card: leftCard,
                            userCanAnswer: gameState != .waiting,
                            onSelect: { selectedEmoji in
                                checkAnswer(selectedEmoji: selectedEmoji)
                            })
                        CardView(card: rightCard,
                                 userCanAnswer: gameState != .waiting,
                                 onSelect: { selectedEmoji in
                                     checkAnswer(selectedEmoji: selectedEmoji)
                                 })
                    }
                    .padding(.horizontal, 10)
                }
            }
            
            PlayerButton(gameState: gameState, score: player2Score, color: .red, onButtonPressed: selectPlayer2)
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.orange)
        .persistentSystemOverlays(.hidden)
        .onAppear {
            createLevel()
        }
        .alert("Game over!", isPresented: $playerHasWon) {
            Button("Start again") {
                isGameActive = false
            }
        } message: {
            if player1Score > player2Score {
                Text("Player 1 won \(player1Score)-\(player2Score)")
            } else {
                Text("Player 2 won \(player1Score)-\(player2Score)")
            }
        }
    }
}

#Preview {
    ContentView(answerTime: 1, itemCount: 9, isGameActive: .constant(true))
}

extension ContentView {
    private func createLevel() {
        currentEmoji = allEmoji.shuffled()
        
        withAnimation(.spring(duration: 0.75)) {
            leftCard = Array(currentEmoji[0..<itemCount]).shuffled()
            
            // create an array with only one duplicated emoji (currentEmoji[0])
            rightCard = Array(currentEmoji[itemCount + 1..<itemCount + itemCount] + [currentEmoji[0]].shuffled())
        }
    }
    
    private func selectPlayer1() {
        guard gameState == .waiting else { return }
        answerColor = .blue
        answerAnchor = .leading
        gameState = .player1Answering
        runClock()
    }
    
    private func selectPlayer2() {
        guard gameState == .waiting else { return }
        answerColor = .red
        answerAnchor = .trailing
        gameState = .player2Answering
        runClock()
    }
    
    private func timeOut() {
        if gameState == .player1Answering {
            player1Score -= 1
        } else if gameState == .player2Answering {
            player2Score -= 1
        }
        
        gameState = .waiting
    }
    
    private func runClock() {
        answerScale = 1
        
        withAnimation(.linear(duration: answerTime)) {
            answerScale = 0
        } completion: {
            timeOut()
        }
    }
    
    private func checkAnswer(selectedEmoji: String) {
        if selectedEmoji == currentEmoji[0] {       // right answer
            if gameState == .player1Answering {
                player1Score += 1
            } else if gameState == .player2Answering {
                player2Score += 1
            }
            
            if player1Score == 5 || player2Score == 5 {
                playerHasWon = true
            } else {
                createLevel()
            }
        } else {    // wrong answer
            if gameState == .player1Answering {
                player1Score -= 1
            } else if gameState == .player2Answering {
                player2Score -= 1
            }
        }
        
        answerColor = .clear
        answerScale = 0
        gameState = .waiting
    }
}
