//
//  CloseButton.swift
//  CryptoApp
//
//  Created by Luis Filipe Pedroso on 11/09/25.
//

import SwiftUI

struct CloseButton: View {
    
    var onPress: () -> Void
    
    var body: some View {
        Button(action: onPress) {
            Image(systemName: "xmark")
                .font(.headline)
        }

    }
}

#Preview {
    CloseButton(onPress: {})
}
