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
                VStack(spacing: 20) {
                    Spacer(minLength: 150)
                    
                    DetailSection(title: "Overview", iterateOver: vm.overviewStatistics)
                    DetailSection(title: "Additional Details", iterateOver: vm.additionalStatistics)
                }
                .padding()
            }
            .navigationTitle(vm.coin.name)
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    DetailView(coin: CoinModel.preview)
}

extension DetailView {
    
    @ViewBuilder
    private func DetailSection(title: String, iterateOver: [StatisticModel]) -> some View {
        Text(title)
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
        
        Divider()
        
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
}
