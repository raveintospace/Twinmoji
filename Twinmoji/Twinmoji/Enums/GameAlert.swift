//
//  GameAlert.swift
//  Twinmoji
//
//  Created by Uri on 17/1/25.
//

enum GameAlert: Identifiable {
    case playerHasWon
    case playerHasLost
    case resetGame
    
    var id: GameAlert {
        return self
    }
}
