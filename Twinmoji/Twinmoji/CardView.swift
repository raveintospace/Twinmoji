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
    
    var rows: Int {
        if card.count == 12 {
            4
        } else {
            3
        }
    }
    
    var body: some View {
        
        // i: rows, j: columns (always 3)
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<rows, id: \.self) { i in
                GridRow {
                    ForEach(0..<3) { j in
                        let text = card[i * 3 + j]
                        
                        Button(text) {
                            // emoji selected
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
    }
}

#Preview {
    CardView(card: ["😁", "😃", "😄", "🥹", "😜", "😎", "😘", "🥸", "🥳"])
}
