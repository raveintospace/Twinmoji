//
//  RulesView.swift
//  Twinmoji
//
//  Created by Uri on 10/2/25.
//

import SwiftUI

struct RulesView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.orange.opacity(0.7).ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text("Game rules")
                    .font(.largeTitle)
                    .underline()
                    .bold()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("- The objective of the game is to find the one identical emoji between the two cards.")
                    Text("- If it's Player 1's turn, Player 2 must start the countdown by tapping their colored area, and Player 1 must tap the repeated emoji on either card before time runs out.")
                    Text("- The same logic applies to Player 2's turn, but in reverse.")
                    Text("- When a player finds the identical emoji, they earn one point. If they miss, they lose one point.")
                    Text("- The first player to reach 5 points wins the game, but the first to reach -5 loses the game.")
                }
                .multilineTextAlignment(.leading)
                .padding()
                
                Button("Close") {
                    dismiss()
                }
                .buttonStyle(.bordered)
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(.rect(cornerRadius: 30))
            }
            .padding()
        }
    }
}

#if DEBUG
#Preview {
    RulesView()
}
#endif
