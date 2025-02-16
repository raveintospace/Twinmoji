//
//  SingleGameAlert.swift
//  Twinmoji
//
//  Created by Uri on 16/2/25.
//

enum SingleGameAlert: Identifiable {
    case hasGameEnded
    case resetGame
    
    var id: SingleGameAlert {
        return self
    }
}
