//
//  HomeView.swift
//  CryptoApp
//
//  Created by Luis Filipe Pedroso on 29/08/25.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    @State private var showPortfolioView: Bool = false
    
    @State private var selectedCoin: CoinModel? = nil
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                        .environmentObject(vm)
                })
            
            VStack {
                HomeHeader
                
                HomeStatsView(showPortfolio: $showPortfolio)
                
                SearchBarView(searchText: $vm.searchText)
                
                ColumnTitles
                
                if !showPortfolio {
                    CoinsList
                        .refreshable {
                            vm.reload()
                        }
                        .transition(.move(edge: .leading))
                } else {
                    PortfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
        }
        .navigationDestination(item: $selectedCoin) { coin in
            DetailView(coin: coin)
        }
    }
    
    private var HomeHeader: some View {
        HStack {
            CircleButtonView(icon: showPortfolio ? "plus" : "info", width: 40, height: 40)
                .animation(.default, value: false)
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            
            Spacer()
            
            Text(showPortfolio ? "Portfolio" : "Live prices")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.theme.accent)
                    .animation(.default, value: false)
            
            Spacer()
            
            CircleButtonView(icon: "chevron.right", width: 40, height: 40)
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var ColumnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity(vm.sortOption == .rank || vm.sortOption == .rankReversed ? 1 : 0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            
            if showPortfolio {
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity(vm.sortOption == .holdings || vm.sortOption == .holdingsReversed ? 1 : 0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity(vm.sortOption == .price || vm.sortOption == .priceReversed ? 1 : 0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
    
    private var CoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 12))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var PortfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 12))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
    }
}

#Preview {
    NavigationView {
        HomeView()
            .toolbar(.hidden)
    }
    .environmentObject(HomeViewModel.preview)
}
