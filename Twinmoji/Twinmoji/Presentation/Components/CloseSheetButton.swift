//
//  CloseSheetButton.swift
//  Twinmoji
//
//  Created by Uri on 15/2/25.
//

import SwiftUI

struct CloseSheetButton: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button("Close") {
            dismiss()
        }
        .buttonStyle(.bordered)
        .foregroundStyle(.white)
        .background(.blue)
        .clipShape(.rect(cornerRadius: 30))
    }
}

#if DEBUG
#Preview {
    CloseSheetButton()
}
#endif
