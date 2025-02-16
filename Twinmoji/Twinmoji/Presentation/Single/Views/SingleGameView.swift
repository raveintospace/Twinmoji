//
//  SingleGameView.swift
//  Twinmoji
//
//  Created by Uri on 15/2/25.
//

import SwiftUI

struct SingleGameView: View {
    
    @ObservedObject var viewModel: SingleViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            gameSpace
            exitGameButton
            playerTurnTitle
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.orange)
        .persistentSystemOverlays(.hidden)
        .toolbarVisibility(.hidden, for: .navigationBar)
        .onAppear {
            viewModel.createLevel()
        }
    }
}

#if DEBUG
#Preview {
    SingleGameView(viewModel: SingleViewModel())
}
#endif

extension SingleGameView {
    
    private var gameSpace: some View {
        ZStack {
            TwinmojiGradient()
            
            if viewModel.leftCard.isEmpty == false {
                playerCards
            }
        }
    }
    
    private var playerCards: some View {
        HStack {
            CardView(
                card: viewModel.leftCard,
                userCanAnswer: viewModel.gameState != .waiting,
                onSelect: { selectedEmoji in
                    viewModel.checkAnswer(selectedEmoji: selectedEmoji)
                })
            
            CardView(card: viewModel.rightCard,
                     userCanAnswer: viewModel.gameState != .waiting,
                     onSelect: { selectedEmoji in
                viewModel.checkAnswer(selectedEmoji: selectedEmoji)
            })
        }
        .padding(.horizontal, 10)
    }
    
    private var exitGameButton: some View {
        Button("Exit game", systemImage: "xmark.circle") {
            // do something
        }
        .symbolVariant(.fill)
        .labelStyle(.iconOnly)
        .font(.largeTitle)
        .tint(.white)
        .padding(40)
    }
    
    private var playerTurnTitle: some View {
        Text("countdown")
            .foregroundStyle(.white)
            .font(.system(size: 24))
            .bold()
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
    }
}
