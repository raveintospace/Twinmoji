//
//  CardView.swift
//  Twinmoji
//
//  Created by Uri on 5/1/25.
//

import SwiftUI

struct CardView: View {
    
    // the emojis on card
    var card: [String]
    
    var userCanAnswer: Bool
    var onSelect: (String) -> Void
    
    var rows: Int {
        if card.count == 12 {
            4
        } else {
            3
        }
    }
    
    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<rows, id: \.self) { i in
                GridRow {
                    ForEach(0..<3) { j in
                        let text = card[i * 3 + j]
                        
                        Button(text) {
                            onSelect(text)
                        }
                    }
                }
            }
        }
        .font(.system(size: 64))
        .padding()
        .background(.white)
        .clipShape(.rect(cornerRadius: 20))
        .fixedSize()
        .shadow(radius: 10)
        .disabled(userCanAnswer == false)
        .transition(.push(from: .top))  // move from top when the card changes
        .id(card)       // updates the whole card, without it only the emojis would be updated
    }
}

#if DEBUG
#Preview {
    CardView(card: ["😁", "😃", "😄", "🥹", "😜", "😎", "😘", "🥸", "🥳"],
             userCanAnswer: true) { _ in }
}
#endif

// i: rows, j: columns (always 3)

