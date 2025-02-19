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
    private var pausedTimeRemaining: Double = 0.0
    
    @Published var playerScore: Int = 0
    @Published var matches: Int = 0
    @Published var rounds: Int = 0
    @Published var hasGameEnded: Bool = false
    
    @Published var showPlayerCards: Bool = false
    
    // MARK: - MenuView properties
    @Published var answerTime: Double = 0.5
    @Published var itemCount: Int = 9
    @Published var isGameActive: Bool = false
    
    // MARK: - Init
    init() {
        scoreboard = getScoreboard()
    }
    
    // MARK: - Methods
    func createLevel() {
        guard gameState != .paused else { return }
        
        currentEmoji = allEmojis.shuffled()
        
        withAnimation(.spring(duration: 0.75)) {
            leftCard = Array(currentEmoji[0..<itemCount]).shuffled()
            
            // create an array with only one duplicated emoji (currentEmoji[0]) inserted randomly
            // currentEmoji[itemCount + 1..<itemCount + itemCount] -> [10..<18] (8 emojis, that are not in left card)
            var tempRightCard = Array(currentEmoji[itemCount + 1..<itemCount + itemCount])
            let duplicateIndex = Int.random(in: 0...tempRightCard.count)
            tempRightCard.insert(currentEmoji[0], at: duplicateIndex)
            
            rightCard = tempRightCard.shuffled()
        }
    }
    
    func activateSinglePlayer() {
        guard gameState == .waiting, rounds < 10 else { return }
        rounds += 1
        gameState = .singlePlayerAnswering
        runClock()
    }
    
    private func timeOut(emojiToCheck: [String]) {
        // guard currentEmoji == emojiToCheck avoids timming out if the cardView has changed
        // guard gameState != .waiting avoids timing out if checkAnswer has been executed
        guard currentEmoji == emojiToCheck, gameState != .waiting else { return }
        
        if gameState == .singlePlayerAnswering {
            penalizePointsForTimeOut()
            
            if rounds == 10 {
                hasGameEnded = true
            }
            
            gameState = .waiting
        }
    }
    
    private func runClock() {
        guard gameState != .paused else { return }
        
        timeRemaining = answerTime
        let checkEmoji = currentEmoji
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            DispatchQueue.main.async {
                if self.timeRemaining > 0 {
                    self.timeRemaining = max(self.timeRemaining - 0.1, 0)
                }
                
                if self.timeRemaining == 0 {
                    self.timer?.invalidate()
                    self.timeOut(emojiToCheck: checkEmoji)
                    
                    // create new level
                    if !self.hasGameEnded {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            self.createLevel()
                            self.activateSinglePlayer()
                        }
                    }
                }
            }
        }
    }
    
    func checkAnswer(selectedEmoji: String) {
        gameState = .waiting
        
        if selectedEmoji == currentEmoji[0] {
            addPoints(timeRemaining: timeRemaining)
            addMatch()
        } else {
            penalizePointsForFailure(timeRemaining: timeRemaining)
        }
        
        checkIfGameHasEndedOrContinues()
    }
    
    private func addPoints(timeRemaining: Double) {
        let baseScore = 100

        let difficultyMultiplier: Double = (itemCount == 9) ? 1.0 : 1.3 // Easy: 1.0, Hard: 1.3
        
        let speedMultiplier: Double = {
            switch answerTime {
            case 5.0: return 1.0  // Slow
            case 2.5: return 1.2  // Medium
            case 1.5: return 1.5  // Fast
            default: return 1.0
            }
        }()
        
        // timeFactor is bigger if answerTime is shorter
        let timeFactor = timeRemaining / answerTime
        let score = Int(Double(baseScore) * timeFactor * difficultyMultiplier * speedMultiplier)
        
        playerScore += max(score, 10)  // Min of 10 points in worst case scenario
    }
    
    private func addMatch() {
        matches += 1
    }
    
    private func penalizePointsForFailure(timeRemaining: Double) {
        let basePenalty = 50
        
        let difficultyMultiplier: Double = (itemCount == 9) ? 1.3 : 1.0  // Easy: 1.3, Hard: 1.0

        let speedMultiplier: Double = {
            switch answerTime {
            case 5.0: return 1.5  // Slow
            case 2.5: return 1.2  // Medium
            case 1.5: return 1.0  // Fast
            default: return 1.0
            }
        }()

        // Bigger penalty when answering faster, to avoid "lottery tactic"
        let timeFactor = 1.0 + (timeRemaining / answerTime)

        // Final penalty calculation
        let penalty = Int(Double(basePenalty) * difficultyMultiplier * speedMultiplier * timeFactor)

        playerScore -= max(penalty, 10)  // Min of 10 points of penalty
    }

    private func penalizePointsForTimeOut() {
        let basePenalty = 30

        let difficultyMultiplier: Double = (itemCount == 9) ? 1.3 : 1.0

        let speedMultiplier: Double = {
            switch answerTime {
            case 5.0: return 1.5  // Slow
            case 2.5: return 1.2  // Medium
            case 1.5: return 1.0  // Fast
            default: return 1.0
            }
        }()

        let penalty = Int(Double(basePenalty) * difficultyMultiplier * speedMultiplier)

        playerScore -= max(penalty, 5)
    }
    
    private func checkIfGameHasEndedOrContinues() {
        if rounds == 10 {
            hasGameEnded = true
        } else {
            createLevel()
            activateSinglePlayer()
        }
    }
    
    func pauseGame() {
        gameState = .paused
        timer?.invalidate()
        pausedTimeRemaining = timeRemaining
    }
    
    func resumeGame() {
        gameState = .singlePlayerAnswering
        runClock()
        timeRemaining = pausedTimeRemaining
    }
    
    func exitGame() {
        timer?.invalidate()
        playerScore = 0
        matches = 0
        rounds = 0
        hasGameEnded = false
        isGameActive = false
    }
    
    // MARK: - Scoreboard
    @Published var scoreboard: [Scorecard] = []
    @Published var showScoreSavedConfirmation: Bool = false
    @Published var showScoreboardResetConfirmation: Bool = false
    
    private let scoreboardLimit: Int = 10
    private let scoreboardUserDefaultsKey: String = "scoreboard"
    
    func saveScore(player: String, deck: String, matches: Int, score: Int) {
        if isScoreboardFull() && isNewHighScore(score: score) {
            removeLowestScore()
        }
        scoreboard.append(Scorecard(player: player, deck: emojisDeck, matches: matches, score: score))
        encodeAndSaveScoreboard()
        showScoreSavedConfirmation = true
    }
    
    func isNewHighScore(score: Int) -> Bool {
        guard score > 0 else { return false }
        
        if scoreboard.isEmpty {
            return true
        }
        return scoreboard.contains { $0.score < score }
    }
    
    func isScoreboardFull() -> Bool {
        return scoreboard.count == scoreboardLimit
    }
    
    func resetScoreboard() {
        scoreboard.removeAll()
        encodeAndSaveScoreboard()
        showScoreboardResetConfirmation = true
    }
    
    private func removeLowestScore() {
        guard let lowestScore = scoreboard.min(by: { $0.score < $1.score })?.score else { return }
        if let index = scoreboard.firstIndex(where: { $0.score == lowestScore }) {
            scoreboard.remove(at: index)
        }
    }
    
    private func encodeAndSaveScoreboard() {
        if let encoded = try? JSONEncoder().encode(scoreboard) {
            UserDefaults.standard.set(encoded, forKey: scoreboardUserDefaultsKey)
        }
    }
    
    private func getScoreboard() -> [Scorecard] {
        if let scoreboardData = UserDefaults.standard.object(forKey: scoreboardUserDefaultsKey) as? Data {
            if let scoreboard = try? JSONDecoder().decode([Scorecard].self, from: scoreboardData) {
                return scoreboard
            }
        }
        return []
    }
}
