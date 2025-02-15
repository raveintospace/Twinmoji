//
//  GoToHomeViewButton.swift
//  Twinmoji
//
//  Created by Uri on 15/2/25.
//

import SwiftUI

struct GoToHomeViewButton: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button("Go to HomeView", systemImage: "house.circle") {
            dismiss()
        }
        .labelStyle(.iconOnly)
        .font(.title)
        .foregroundStyle(.blue)
        .padding(8)
    }
}

#if DEBUG
#Preview {
    GoToHomeViewButton()
}
#endif
