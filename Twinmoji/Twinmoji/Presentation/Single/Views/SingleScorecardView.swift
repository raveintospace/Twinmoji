//
//  SingleScorecardView.swift
//  Twinmoji
//
//  Created by Uri on 15/2/25.
//

import SwiftUI

struct SingleScorecardView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.orange.opacity(0.7).ignoresSafeArea()
            
            VStack(spacing: 10) {
                CloseSheetButton()
                // scoreboard as in memoroji
            }
            .padding()
        }
    }
}

#if DEBUG
#Preview {
    SingleScorecardView()
}
#endif
