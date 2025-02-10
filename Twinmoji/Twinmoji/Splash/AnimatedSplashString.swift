//
//  AnimatedSplashString.swift
//  Twinmoji
//
//  Created by Uri on 10/2/25.
//


import SwiftUI

struct AnimatedSplashString: View {

    let text: String
    @Binding var isAnimating: Bool

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(text.enumerated()), id: \.offset) { index, letter in
                Text(String(letter))
                    .font(.system(size: 30, weight: .heavy, design: .serif))
                    .foregroundStyle(.twinmojiBlue)
                    .shadow(color: .twinmojiRed, radius: 2, x: 0, y: 0)
                    .rotation3DEffect(
                        .degrees(isAnimating ? 360 : 0),
                        axis: (x: 1, y: 0, z: 0))
                    .animation(.spring(duration: 1.5)
                        .delay(Double(index) * 0.05), value: isAnimating)
            }
        }
        .padding()
        .onAppear {
            isAnimating = true
        }
    }
}

#if DEBUG
#Preview {
    AnimatedSplashString(text: "Created by Uri46", isAnimating: .constant(true))
}
#endif
