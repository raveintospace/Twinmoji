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
                
                VStack(spacing: 18) {
                    homeViewTitle
                    singleButton
                    battleButton
                }
            }
            .navigationDestination(isPresented: $showSingleMenuView) {
                SingleGameView()
            }
            .navigationDestination(isPresented: $showBattleMenuView) {
                BattleMenuView()
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
        Text("Select game mode")
            .font(.title)
            .bold()
            .underline()
            .foregroundStyle(.black)
    }
    
    private var singleButton: some View {
        ButtonBorderColorAnimated(text: "Single") {
            showSingleMenuView.toggle()
        }
    }
    
    private var battleButton: some View {
        ButtonBorderColorAnimated(text: "Battle") {
            showBattleMenuView.toggle()
        }
    }
}
