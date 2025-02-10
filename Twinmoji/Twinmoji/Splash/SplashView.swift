//
//  SplashView.swift
//  Twinmoji
//
//  Created by Uri on 10/2/25.
//

import SwiftUI

struct SplashView: View {
    
    @State private var imageOpacity: Double = 0
    
    @Binding var showSplashView: Bool
    
    var body: some View {
        ZStack {
            SplashGradient()
            
            VStack {
                logoImage
                splashCreatorText
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        showSplashView = false
                    }
                }
                
                withAnimation(.easeIn(duration: 1)) {
                    imageOpacity = 1
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
    private var logoImage: some View {
        Image("logo")
            .resizable()
            .frame(width: 250, height: 250)
            .clipShape(.rect(cornerRadius: 10))
            .opacity(imageOpacity)
    }
    
    private var splashCreatorText: some View {
        Text("Created by Uri46")
            .font(.system(size: 30, weight: .heavy, design: .serif))
            .foregroundStyle(.twinmojiBlue)
            .shadow(color: .twinmojiRed, radius: 2, x: 0, y: 0)
            .opacity(imageOpacity)
    }
}
