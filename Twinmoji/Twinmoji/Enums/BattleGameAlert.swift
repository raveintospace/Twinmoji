//
//  GameAlert.swift
//  Twinmoji
//
//  Created by Uri on 17/1/25.
//

enum BattleGameAlert: Identifiable {
    case playerHasWon
    case playerHasLost
    case resetGame
    
    var id: BattleGameAlert {
        return self
    }
}
