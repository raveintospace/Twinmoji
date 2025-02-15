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
        Text("Single game view")
    }
}

#if DEBUG
#Preview {
    SingleGameView(viewModel: SingleViewModel())
}
#endif
