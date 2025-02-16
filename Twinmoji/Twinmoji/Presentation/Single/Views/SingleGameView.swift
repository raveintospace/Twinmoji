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
            timeLeftText
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(TwinmojiGradient())
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
        HStack(spacing: 0) {
            pointsRectangle
            
            ZStack {
                if viewModel.leftCard.isEmpty == false {
                    playerCards
                }
            }
            
            roundsRectangle
        }
    }
    
    private var pointsRectangle: some View {
        Rectangle()
            .fill(.clear)
            .frame(minWidth: 30)
            .overlay(
                VStack(alignment: .center) {
                    Text("Points:")
                    Text(String(viewModel.playerPoints))
                }
                    .fixedSize()
                    .font(.system(size: 22))
                    .foregroundStyle(.white)
                    .bold()
            )
    }
    
    private var roundsRectangle: some View {
        Rectangle()
            .fill(.clear)
            .frame(minWidth: 30)
            .overlay(
                VStack(alignment: .center) {
                    Text("Rounds:")
                    Text("\(viewModel.rounds) / 10")
                }
                    .fixedSize()
                    .font(.system(size: 22))
                    .foregroundStyle(.white)
                    .bold()
            )
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
            // opaque card & show alert
        }
        .symbolVariant(.fill)
        .labelStyle(.iconOnly)
        .font(.largeTitle)
        .tint(.white)
        .padding(40)
    }
    
    private var timeLeftText: some View {
        Text("Time left: \(String(format: "%.2f", viewModel.timeRemaining))")
            .foregroundStyle(.white)
            .font(.system(size: 24))
            .bold()
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
    }
}
