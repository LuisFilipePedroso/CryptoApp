//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Luis Filipe Pedroso on 05/09/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    private let dataService = CoinDataService()
    private var cancellables: Set<AnyCancellable> = []
    
    init () {
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] (allCoins) in
                self?.allCoins = allCoins
            }
            .store(in: &cancellables)
    }
}
