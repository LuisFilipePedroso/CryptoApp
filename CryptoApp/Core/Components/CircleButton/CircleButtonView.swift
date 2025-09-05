//
//  CircleButtonView.swift
//  CryptoApp
//
//  Created by Luis Filipe Pedroso on 29/08/25.
//

import SwiftUI

struct CircleButtonView: View {
    
    let icon: String
    var width: CGFloat = 50
    var height: CGFloat = 50
    
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 16, weight: .medium))
            .foregroundStyle(Color.theme.accent)
            .frame(width: width, height: height)
            .background {
                Circle()
                    .foregroundStyle(Color.theme.background)
            }
            .shadow(
                color: Color.theme.accent.opacity(0.25),
                radius: 10, x: 0, y: 0
            )
            .padding()
    }
}

#Preview("Light mode", traits: .sizeThatFitsLayout) {
    CircleButtonView(icon: "info")
        .padding()
}

#Preview("Dark mode", traits: .sizeThatFitsLayout) {
    CircleButtonView(icon: "info")
        .preferredColorScheme(.dark)
}
