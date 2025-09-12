//
//  CoinLogoView.swift
//  CryptoApp
//
//  Created by Luis Filipe Pedroso on 11/09/25.
//

import SwiftUI

struct CoinLogoView: View {
    
    let coin: CoinModel
    
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 48, height: 48)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinLogoView(coin: CoinModel.preview)
}
