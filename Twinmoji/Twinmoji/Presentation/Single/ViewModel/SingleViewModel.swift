//
//  SingleViewModel.swift
//  Twinmoji
//
//  Created by Uri on 15/2/25.
//

import SwiftUI

@MainActor
final class SingleViewModel: ObservableObject {
    
    // MARK: - ContentView properties
    @Published var emojisDeck: Deck = .faces
    var allEmojis: [String] {
        emojisDeck.emojis
    }
    
    @Published var currentEmoji: [String] = []
    
    @Published var leftCard: [String] = []
    @Published var rightCard: [String] = []
    
    @Published var gameState: GameState = .waiting
    
    @Published var answerColor: Color = .clear
    @Published var answerScale: CGFloat = 1.0
    @Published var answerAnchor: UnitPoint = .center
    
    @Published var score: Int = 0
    @Published var rounds: Int = 10
    @Published var hasGameEnded: Bool = false
    
    // MARK: - MenuView properties
    @Published var answerTime: Double = 1.0
    @Published var itemCount: Int = 9
    @Published var isGameActive: Bool = false
    
    // MARK: - Methods
    func createLevel() {
        currentEmoji = allEmojis.shuffled()
        
        withAnimation(.spring(duration: 0.75)) {
            leftCard = Array(currentEmoji[0..<itemCount]).shuffled()
            
            // create an array with only one duplicated emoji (currentEmoji[0]) inserted randomly
            // currentEmoji[itemCount + 1..<itemCount + itemCount] -> [10..<18] (8 emojis, that are not in left card
            var tempRightCard = Array(currentEmoji[itemCount + 1..<itemCount + itemCount])
            let duplicateIndex = Int.random(in: 0...tempRightCard.count)
            tempRightCard.insert(currentEmoji[0], at: duplicateIndex)
            
            rightCard = tempRightCard.shuffled()
        }
    }
    
    // TO DO: - activate time
    func activateSinglePlayer() {
        guard gameState == .waiting else { return }
        answerColor = .twinmojiRed
        answerAnchor = .leading
        gameState = .singlePlayerAnswering
        runClock()
    }
    
    private func timeOut(emojiToCheck: [String]) {
        // guard currentEmoji == emojiToCheck avoids timming out if the cardView has changed
        // guard gameState != .waiting avoids timing out if checkAnswer has been executed
        guard currentEmoji == emojiToCheck, gameState != .waiting else { return }
        
        if gameState == .singlePlayerAnswering {
            // extractpointsaftertimingout
            
            if rounds == 0 {
                hasGameEnded = true
            }
            
            gameState = .waiting
        }
    }
    
    private func runClock() {
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
            // add points
            
            if rounds == 0 {
                hasGameEnded = true
            } else {
                createLevel()
            }
        } else {    // wrong answer
            // substract points
            
            if rounds == 0 {
                hasGameEnded = true
            } else {
                createLevel() // -> create level for each round
            }
        }
        
        answerColor = .clear
        answerScale = 0
        gameState = .waiting
    }
    
    func exitGame() {
        score = 0
        rounds = 10
        hasGameEnded = false
        isGameActive = false
    }
}
