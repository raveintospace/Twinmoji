//
//  ButtonBorderColorAnimated.swift
//  Twinmoji
//
//  Created by Uri on 15/2/25.
//

import SwiftUI

struct ButtonBorderGradient: View {
    
    var text: String
    var onButtonPressed: (() -> Void)?
    var buttonGradient: Gradient = Gradient(colors: [.twinmojiRed, .twinmojiBlue])
    var duration: Double = 1.5
    var buttonWidth: CGFloat = 200
    var gradientHeight: CGFloat = 43
    var buttonHeight: CGFloat = 40
    var cornerRadius: CGFloat = 20
    var radius: CGFloat = 1
    var fontName: String?
    var fontSize: CGFloat = 20
    var fontWeight: Font.Weight = .bold
    var textYOffset: CGFloat = 0
    
    var body: some View {
        Button(action: {
            onButtonPressed?()
        }) {
            Text(text)
                .font(
                    fontName != nil ?
                        .custom(fontName!, size: fontSize).weight(fontWeight) : .system(size: fontSize, weight: fontWeight)
                )
                .offset(y: textYOffset)
                .foregroundStyle(.black)
                .frame(width: buttonWidth, height: buttonHeight)
                .background(RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white.opacity(0.8)))
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(
                            LinearGradient(
                                gradient: buttonGradient,
                                startPoint: .bottomLeading,
                                endPoint: .topTrailing
                            ),
                            lineWidth: 4
                        )
                        .blur(radius: radius)
                )
        }
    }
}

#if DEBUG
#Preview {
    ZStack {
        TwinmojiGradient()
        
        VStack(spacing: 20) {
            ButtonBorderGradient(text: "Single")
            ButtonBorderGradient(text: "Battle")
        }
    }
}
#endif
