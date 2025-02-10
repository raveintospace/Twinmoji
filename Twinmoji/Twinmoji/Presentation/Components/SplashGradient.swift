//
//  SplashGradient.swift
//  Twinmoji
//
//  Created by Uri on 10/2/25.
//

import SwiftUI

struct SplashGradient: View {
    var body: some View {
        LinearGradient(gradient: Gradient(stops: [
            .init(color: .twinmojiBlue, location: 0.0),
            .init(color: .twinmojiRed, location: 0.8)
        ]), startPoint: .leading, endPoint: .trailing)
        .ignoresSafeArea()
    }
}

#if DEBUG
#Preview {
    SplashGradient()
}
#endif
