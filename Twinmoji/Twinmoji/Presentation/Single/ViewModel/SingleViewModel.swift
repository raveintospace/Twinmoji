//
//  SingleViewModel.swift
//  Twinmoji
//
//  Created by Uri on 15/2/25.
//

import SwiftUI

@MainActor
final class SingleViewModel: ObservableObject {
    
    // MARK: - GameView properties
    @Published var emojisDeck: Deck = .faces
    var allEmojis: [String] {
        emojisDeck.emojis
    }
    
    @Published var currentEmoji: [String] = []
    
    @Published var leftCard: [String] = []
    @Published var rightCard: [String] = []
    
    @Published var gameState: GameState = .waiting
    
    private var timer: Timer?
    @Published var timeRemaining: Double = 0.0
    
    @Published var answerColor: Color = .clear
    @Published var answerScale: CGFloat = 1.0
    @Published var answerAnchor: UnitPoint = .center
    
    @Published var playerPoints: Int = 0
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
        timeRemaining = answerTime
        answerScale = 1
        let checkEmoji = currentEmoji
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            DispatchQueue.main.async {
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 0.1
                } else {
                    self.timer?.invalidate()
                    self.timeOut(emojiToCheck: self.currentEmoji)
                }
            }
        }
        
        withAnimation(.linear(duration: answerTime)) {
            answerScale = 0
        }
    }
    
    func checkAnswer(selectedEmoji: String) {
        if selectedEmoji == currentEmoji[0] {
            addPoints(timeRemaining: timeRemaining)
        } else {
            // substract points
        }
        
        checkIfGameHasEndedOrContinues()
        
        answerColor = .clear
        answerScale = 0
        gameState = .waiting
    }
    
    private func addPoints(timeRemaining: Double) {
        let baseScore = 100

        let difficultyMultiplier: Double = (itemCount == 9) ? 1.0 : 1.3 // Easy: 1.0, Hard: 1.3
        
        let speedMultiplier: Double = {
            switch answerTime {
            case 2.0: return 1.0  // Slow
            case 1.0: return 1.2  // Medium
            case 0.5: return 1.5  // Fast
            default: return 1.0
            }
        }()
        
        // timeFactor is bigger if answerTime is shorter
        let timeFactor = timeRemaining / answerTime
        let score = Int(Double(baseScore) * timeFactor * difficultyMultiplier * speedMultiplier)
        
        playerPoints += max(score, 10)  // Min of 10 points in worst case scenario
    }
    
    private func checkIfGameHasEndedOrContinues() {
        if rounds == 0 {
            hasGameEnded = true
        } else {
            createLevel()
        }
    }
    
    func exitGame() {
        timer?.invalidate()
        playerPoints = 0
        rounds = 10
        hasGameEnded = false
        isGameActive = false
    }
}
