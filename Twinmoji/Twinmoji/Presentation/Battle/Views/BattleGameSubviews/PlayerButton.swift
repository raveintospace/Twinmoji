//
//  PlayerButton.swift
//  Twinmoji
//
//  Created by Uri on 5/1/25.
//

import SwiftUI

struct PlayerButton: View {
    
    var gameState: GameState
    var playerNumber: String
    var score: Int
    var color: Color
    var onButtonPressed: () -> Void
    
    var body: some View {
        Button(action: onButtonPressed) {
            Rectangle()
                .fill(color)
                .frame(minWidth: 60)
                .overlay(
                    VStack(alignment: .center) {
                        Text("P\(playerNumber):")
                        Text(String(score))
                    }
                        .fixedSize()
                        .font(.system(size: 48))
                        .foregroundStyle(.white)
                        .bold()
                )
        }
        .disabled(gameState != .waiting)
    }
}

#if DEBUG
#Preview {
    PlayerButton(
        gameState: .waiting,
        playerNumber: "1",
        score: 5,
        color: .twinmojiBlue
    ) {
        //
    }
}
#endif
