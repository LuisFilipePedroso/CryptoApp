//
//  DetailView.swift
//  CryptoApp
//
//  Created by Luis Filipe Pedroso on 16/09/25.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var vm: DetailViewModel
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 32

    init(coin: CoinModel) {
        self._vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ChartView(coin: vm.coin)
                        .padding(.vertical)
                    
                    VStack(spacing: 20) {
                        DetailSectionTitle(title: "Overview")
                        Divider()
                        DetailSectionGrid(iterateOver: vm.overviewStatistics)
                        
                        DetailSectionTitle(title: "Additional Details")
                        Divider()
                        DetailSectionGrid(iterateOver: vm.additionalStatistics)
                    }
                    .padding()
                }
            }
            .navigationTitle(vm.coin.name)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationBarTrailingItems
                }
            }
        }
    }
}

#Preview {
    DetailView(coin: CoinModel.preview)
}

extension DetailView {
    
    @ViewBuilder
    private func DetailSectionTitle(title: String) -> some View {
        Text(title)
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
        
//        Divider()
    }
    
    @ViewBuilder
    private func DetailSectionGrid(iterateOver: [StatisticModel]) -> some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            content: {
                ForEach(iterateOver) { data in
                    StatisticView(stat: StatisticModel(title: data.title, value: data.value))
                }
            }
        )
    }
    
    private var NavigationBarTrailingItems: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 24, height: 24)
        }
    }
}
