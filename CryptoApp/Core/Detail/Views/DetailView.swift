//
//  DetailView.swift
//  CryptoApp
//
//  Created by Luis Filipe Pedroso on 16/09/25.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var vm: DetailViewModel
    @State private var showFullDescription: Bool = false
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
                        DescriptionSection
                        DetailSectionGrid(iterateOver: vm.overviewStatistics)
                        
                        DetailSectionTitle(title: "Additional Details")
                        Divider()
                        DetailSectionGrid(iterateOver: vm.additionalStatistics)
                        LinksSection
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
    }
    
    private var DescriptionSection: some View {
        ZStack {
            if let description = vm.coinDescription, !description.isEmpty {
                VStack(alignment: .leading) {
                    Text(description)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondaryText)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Less" : "Read more...")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(.vertical, 4)
                    }
                    .tint(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
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
    
    private var LinksSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let website = vm.website,
               let url = URL(string: website) {
                Link("Website", destination: url)
            }
            
            if let reddit = vm.redditURL,
               let url = URL(string: reddit) {
                Link("Reddit", destination: url)
            }
        }
        .tint(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
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
