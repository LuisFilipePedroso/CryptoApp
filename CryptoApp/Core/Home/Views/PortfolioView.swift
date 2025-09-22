//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by Luis Filipe Pedroso on 11/09/25.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false

    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    CoinsList()
                    
                    if selectedCoin != nil {
                        PortfolioInputSection()
                    }
                    
                }
            }
            .background(Color.theme.background.ignoresSafeArea())
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CloseButton(onPress: {
                        presentationMode.wrappedValue.dismiss()
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    SaveButton()
                }
            }
            .onChange(of: vm.searchText) { _, value in
                if value.isEmpty {
                    removeSelectedCoin()
                }
            }
        }
    }
}

extension PortfolioView {
    
    @ViewBuilder
    private func CoinsList() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinListItem(coin: coin)
                }
            }
            .frame(height: 120)
            .padding(.leading)
        }
    }
    
    @ViewBuilder
    private func CoinListItem(coin: CoinModel) -> some View {
        CoinLogoView(coin: coin)
            .padding(4)
            .onTapGesture {
                withAnimation(.easeIn(duration: 0.15)) {
                    updateSelected(coin)
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
            )
    }
    
    private func updateSelected(_ coin: CoinModel) {
        selectedCoin = coin
        
        guard
            let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
            let amount = portfolioCoin.currentHoldings
        else {
            quantityText = ""
            return
        }
        
        quantityText = "\(amount)"
    }
    
    @ViewBuilder
    private func PortfolioInputSection() -> some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount holding:")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.default, value: false)
        .padding()
        .font(.headline)
    }
    
    @ViewBuilder
    private func SaveButton() -> some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1 : 0)
            
            Button {
                onPressSave()
            } label: {
                Text("Save".uppercased())
            }
            .opacity(
                (selectedCoin?.currentHoldings != Double(quantityText)) ? 1 : 0
            )
        }
        .font(.headline)
        .animation(.easeInOut(duration: 0.2), value: selectedCoin?.currentHoldings != Double(quantityText))
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        
        return 0
    }
    
    private func onPressSave() {
       
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
            else {
                return
            }
        
        // Save to Portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        // Show Checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
        }
        
        // Hide Keyboard
        
        // Hide Checkbmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckmark = false
                removeSelectedCoin()
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
        quantityText = ""
    }
}

#Preview {
    PortfolioView()
        .environmentObject(HomeViewModel.preview)
}
