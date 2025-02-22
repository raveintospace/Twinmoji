//
//  SingleScoreboardView.swift
//  Twinmoji
//
//  Created by Uri on 15/2/25.
//

import SwiftUI

struct SingleScoreboardView: View {
    
    @ObservedObject var viewModel: SingleViewModel
    
    @State private var showResetAlert: Bool = false
    
    var body: some View {
        ZStack {
            Color.orange.opacity(0.7).ignoresSafeArea()
            
            VStack(spacing: 10) {
                scoreGrid
                scoreboardButtons
            }
            .foregroundStyle(.black)
            .padding()
            .alert(isPresented: $showResetAlert) {
                Alert(
                    title: Text("Reset scoreboard"),
                    message: Text("Do you want to erase the scores saved?"),
                    primaryButton: .destructive(Text("Reset")) { viewModel.resetScoreboard()
                    },
                    secondaryButton: .default(Text("Discard"))
                )
            }
        }
    }
}

#if DEBUG
#Preview {
    SingleScoreboardView(viewModel: SingleViewModel())
}
#endif

extension SingleScoreboardView {
    
    private var scoreGrid: some View {
        ScrollView {
            Grid(alignment: .leadingFirstTextBaseline,
                 horizontalSpacing: 20,
                 verticalSpacing: 10) {
                GridRow {
                    Text("PLAYER")
                    Text("DECK")
                        .gridColumnAlignment(.center)
                    Text("MATCHES")
                        .gridColumnAlignment(.center)
                    Text("SCORE")
                        .gridColumnAlignment(.trailing)
                }
                .font(.callout)
                .bold()
                
                Divider()
                    .frame(minHeight: 3)
                    .overlay(.black)
                
                ForEach(viewModel.scoreboard.sorted(by: { $0.score > $1.score })) { score in
                    GridRow(alignment: .center) {
                        Text(score.player)
                        Text(score.deck.rawValue)
                            .gridColumnAlignment(.center)
                            .multilineTextAlignment(.center)
                        Text("\(score.matches)")
                            .gridColumnAlignment(.center)
                        Text("\(score.score)")
                            .gridColumnAlignment(.trailing)
                    }
                    Divider()
                        .frame(minHeight: 1)
                        .overlay(.black.opacity(0.5))
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal)
        .padding(.top, 20)
    }
    
    private var resetScoreboardButton: some View {
        Button("Reset") {
            showResetAlert = true
        }
        .buttonStyle(.bordered)
        .foregroundStyle(.white)
        .background(.red)
        .clipShape(.rect(cornerRadius: 30))
    }
    
    private var scoreboardButtons: some View {
        HStack(spacing: 10) {
            CloseSheetButton()
            resetScoreboardButton
        }
    }
}

