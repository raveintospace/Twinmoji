//
//  ContentViewModel.swift
//  Twinmoji
//
//  Created by Uri on 13/1/25.
//

import SwiftUI

@Observable
@MainActor
final class ContentViewModel {
    
    let allEmoji = Array("😎🥹🥰😔😂😳🧐🙂😇😅😆😙😬🙃😍🥸😣😶🙄🤨😩😉🥲😋😛🤓😏😭😯😵😐😘😢😠").map(String.init)
    
    var currentEmoji: [String] = []
    
    var leftCard: [String] = []
    var rightCard: [String] = []
    
    var gameState: GameState = GameState.waiting
    
    var player1Score: Int = 0
    var player2Score: Int = 0
    
    var answerColor: Color = .clear
    var answerScale: CGFloat = 1.0
    var answerAnchor: UnitPoint = .center
    
    var playerHasWon: Bool = false
    
}


