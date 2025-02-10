//
//  SplashView.swift
//  Twinmoji
//
//  Created by Uri on 10/2/25.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isTextAnimating: Bool = false
    private let creatorText: String = "Created by Uri46"

    @Binding var showSplashView: Bool
    
    var body: some View {
        splashCreatorText
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        showSplashView = false
                    }
                }
            }
    }
}

#if DEBUG
#Preview {
    SplashView(showSplashView: .constant(true))
}
#endif

extension SplashView {
    private var splashCreatorText: some View {
        AnimatedSplashString(text: creatorText, isAnimating: $isTextAnimating)
    }
}
