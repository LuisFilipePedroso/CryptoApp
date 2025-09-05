//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Luis Filipe Pedroso on 05/09/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    init () {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.allCoins.append(CoinModel.preview)
            self.portfolioCoins.append(CoinModel.preview)
        }
    }
}
