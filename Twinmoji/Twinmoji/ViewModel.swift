//
//  ContentViewModel.swift
//  Twinmoji
//
//  Created by Uri on 13/1/25.
//

import SwiftUI

@MainActor
final class ViewModel: ObservableObject {
    
    // MARK: - ContentView properties
    let allEmoji = Array("😎🥹🥰😔😂😳🧐🙂😇😅😆😙😬🙃😍🥸😣😶🙄🤨😩😉🥲😋😛🤓😏😭😯😵😐😘😢😠").map(String.init)
    
    @Published var currentEmoji: [String] = []
    
    @Published var leftCard: [String] = []
    @Published var rightCard: [String] = []
    
    @Published var gameState: GameState = GameState.waiting
    
    @Published var player1Score: Int = 0
    @Published var player2Score: Int = 0
    
    @Published var answerColor: Color = .clear
    @Published var answerScale: CGFloat = 1.0
    @Published var answerAnchor: UnitPoint = .center
    
    @Published var playerHasWon: Bool = false
    
    // MARK: - MenuView properties
    @Published var answerTime: Double = 1.0
    @Published var itemCount: Int = 9
    @Published var isGameActive: Bool = false
    
    
    // MARK: - Methods
    func createLevel() {
        currentEmoji = allEmoji.shuffled()
        
        withAnimation(.spring(duration: 0.75)) {
            leftCard = Array(currentEmoji[0..<itemCount]).shuffled()
            
            // create an array with only one duplicated emoji (currentEmoji[0])
            rightCard = Array(currentEmoji[itemCount + 1..<itemCount + itemCount] + [currentEmoji[0]].shuffled())
        }
    }
    
    func selectPlayer1() {
        guard gameState == .waiting else { return }
        answerColor = .blue
        answerAnchor = .leading
        gameState = .player1Answering
        runClock()
    }
    
    func selectPlayer2() {
        guard gameState == .waiting else { return }
        answerColor = .red
        answerAnchor = .trailing
        gameState = .player2Answering
        runClock()
    }
    
    func timeOut(emojiToCheck: [String]) {
        guard currentEmoji == emojiToCheck else { return } // avoids timming out if the cardView has changed
        
        if gameState == .player1Answering {
            player1Score -= 1
        } else if gameState == .player2Answering {
            player2Score -= 1
        }
        
        gameState = .waiting
    }
    
    func runClock() {
        answerScale = 1
        let checkEmoji = currentEmoji
        
        withAnimation(.linear(duration: answerTime)) {
            answerScale = 0
        } completion: {
            self.timeOut(emojiToCheck: checkEmoji)
        }
    }
    
    func checkAnswer(selectedEmoji: String) {
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

// TO DO:
/*
 create the cards random
 reset scores when game finishes (won or exit by user) 
 */
