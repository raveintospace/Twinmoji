//
//  SingleRulesView.swift
//  Twinmoji
//
//  Created by Uri on 15/2/25.
//

import SwiftUI

struct SingleRulesView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.orange.opacity(0.7).ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text("Single rules")
                    .font(.largeTitle)
                    .underline()
                    .bold()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("- The objective of the game is to find the one identical emoji between the two cards before time runs out.")
                    Text("- The player earns points based on the time remaining when they find the matching emoji, the faster, the more points earned.")
                    Text("- If the player fails to tap the correct emoji, points are deducted based on the remaining time, the faster, the more points lost.")
                    Text("- The game consists of ten rounds in total")
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
    SingleRulesView()
}
#endif
