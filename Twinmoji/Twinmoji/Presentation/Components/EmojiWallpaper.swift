//
//  EmojiWallpaper.swift
//  Twinmoji
//
//  Created by Uri on 23/2/25.
//

import SwiftUI

struct EmojiWallpaper: View {
    private let wallpaperEmojis = [
        "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🐧",
        "🐦", "🦆", "🦅", "🦉", "🐴", "🦄", "🐢", "🐍", "🐙", "🦈", "🐳", "🐋", "🦓", "🦒", "🦔", "🦥", "🦩",
        "😎", "🥹", "🥰", "😔", "😂", "😳", "🧐", "🙂", "😇", "😅", "😆", "😙", "😬", "🙃", "😍", "🥸",
        "😣", "😶", "🙄", "🤨", "😩", "😉", "🥲", "😋", "😛", "🤓", "😏", "😭", "😯", "😵", "😐", "😘",
        "😢", "😠", "🍎", "🍊", "🍋", "🍉", "🍇", "🍓", "🍒", "🍍", "🥭", "🍌", "🍑", "🥝", "🥥", "🍅",
        "🍆", "🥕", "🍕", "🌽", "🥔", "🍠", "🍿", "🥐", "🥖", "🥨", "🥯", "🍞", "🥞", "🧇", "🧀", "🥩",
        "🍗", "🍖", "🥓"
    ].shuffled()
    
    var body: some View {
        GeometryReader { geometry in
            Grid(horizontalSpacing: 20, verticalSpacing: 20) {
                ForEach(0..<5) { row in
                    GridRow {
                        ForEach(0..<10) { col in
                            Text(wallpaperEmojis[(row * 10 + col) % wallpaperEmojis.count])
                                .font(.system(size: 70))
                                .opacity(0.15)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
        }
    }
}
