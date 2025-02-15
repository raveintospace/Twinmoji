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
    var allEmoji: [String] {
        emojisDeck.emojis
    }
    
    @Published var currentEmoji: [String] = []
    
    @Published var leftCard: [String] = []
    @Published var rightCard: [String] = []
    
    @Published var gameState: GameState = .waiting
    
    @Published var answerColor: Color = .clear
    @Published var answerScale: CGFloat = 1.0
    @Published var answerAnchor: UnitPoint = .center
    
    @Published var rounds: Int = 10
    @Published var gameHasEnded: Bool = false
    
    private var pointsToWin: Int = 5
    private var pointsToLose: Int = -5
    
    // MARK: - MenuView properties
    @Published var answerTime: Double = 1.0
    @Published var itemCount: Int = 9
    @Published var isGameActive: Bool = false
    
}
