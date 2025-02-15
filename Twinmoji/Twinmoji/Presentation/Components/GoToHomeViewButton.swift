//
//  GoToHomeViewButton.swift
//  Twinmoji
//
//  Created by Uri on 15/2/25.
//

import SwiftUI

struct GoToHomeViewButton: View {
    
    var onGoToHomeViewButtonPressed: (() -> Void)?
    
    var body: some View {
        Button("Go to HomeView", systemImage: "house.circle") {
            onGoToHomeViewButtonPressed?()
        }
        .labelStyle(.iconOnly)
        .font(.title)
        .padding(8)
    }
}

#if DEBUG
#Preview {
    GoToHomeViewButton()
}
#endif
