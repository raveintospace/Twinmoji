//
//  PlayerButton.swift
//  Twinmoji
//
//  Created by Uri on 5/1/25.
//

import SwiftUI

struct PlayerButton: View {
    
    var gameState: GameState
    var score: Int
    var color: Color
    var onButtonPressed: () -> Void
    
    var body: some View {
        Button(action: onButtonPressed) {
            Rectangle()
                .fill(color)
                .frame(minWidth: 60)
                .overlay(
                    Text(String(score))
                        .fixedSize()
                        .foregroundStyle(.white)
                        .font(.system(size: 48))
                        .bold()
                )
        }
        .disabled(gameState != .waiting)
    }
}

#Preview {
    PlayerButton(gameState: .waiting, score: 5, color: .blue) {
        //
    }
}
