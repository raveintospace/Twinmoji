//
//  HomeView.swift
//  Twinmoji
//
//  Created by Uri on 15/2/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showSingleMenuView: Bool = false
    @State private var showBattleMenuView: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                TwinmojiGradient()
                EmojiWallpaper()
                
                VStack(spacing: 18) {
                    homeViewTitle
                    singleButton
                    battleButton
                }
            }
            .navigationDestination(isPresented: $showSingleMenuView) {
                SingleMenuView()
                    .preferredColorScheme(.light)
            }
            .navigationDestination(isPresented: $showBattleMenuView) {
                BattleMenuView()
                    .preferredColorScheme(.light)
            }
        }
    }
}

#if DEBUG
#Preview {
    HomeView()
}
#endif

extension HomeView {
    
    private var homeViewTitle: some View {
        Text("SELECT GAME MODE")
            .font(.title)
            .bold()
            .underline()
            .foregroundStyle(.black)
    }
    
    private var singleButton: some View {
        ButtonBorderGradient(text: "Single") {
            showSingleMenuView.toggle()
        }
    }
    
    private var battleButton: some View {
        ButtonBorderGradient(text: "Battle") {
            showBattleMenuView.toggle()
        }
    }
}
