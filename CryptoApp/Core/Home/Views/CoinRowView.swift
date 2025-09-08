//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by Luis Filipe Pedroso on 04/09/25.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            LeftColumn()
            
            Spacer()
            
            if showHoldingsColumn {
                CenterColumn()
            }
            
            RightColumn()
            
        }
        .font(.subheadline)
    }
    
    @ViewBuilder
    private func LeftColumn() -> some View {
        
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
            .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
        }
    }
    
    @ViewBuilder
    private func CenterColumn() -> some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundStyle(Color.theme.accent)
    }
    
    @ViewBuilder
    private func RightColumn() -> some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundStyle((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}

#Preview("Light Mode", traits: .sizeThatFitsLayout) {
    CoinRowView(coin: CoinModel.preview, showHoldingsColumn: true)
}

#Preview("Dark Mode", traits: .sizeThatFitsLayout) {
    CoinRowView(coin: CoinModel.preview, showHoldingsColumn: true)
        .preferredColorScheme(.dark)
}
