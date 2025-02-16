//
//  SingleRulesView.swift
//  Twinmoji
//
//  Created by Uri on 15/2/25.
//

import SwiftUI

struct SingleRulesView: View {
        
    var body: some View {
        ZStack {
            Color.orange.opacity(0.7).ignoresSafeArea()
            
            VStack(spacing: 10) {
                singleRulesTitle
                VStackOfRules
                CloseSheetButton()
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

extension SingleRulesView {
    
    private var singleRulesTitle: some View {
        Text("Single rules")
            .font(.largeTitle)
            .underline()
            .bold()
    }
    
    private var VStackOfRules: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("- The objective of the game is to find the only identical emoji between the two cards before time runs out.")
            Text("- Points are awarded based on the remaining time, the available time for the round and the number of emojis displayed. The faster you find the match, the more points you earn.")
            Text("- If you tap a wrong emoji or fail to respond before time runs out, points are deducted based on the same factors. The faster the mistake, the higher the penalty.")
            Text("- Tapping a wrong emoji is more penalizing than failing to respond.")
            Text("- The game consists of ten rounds in total.")
        }
        .multilineTextAlignment(.leading)
        .padding()
    }
}
