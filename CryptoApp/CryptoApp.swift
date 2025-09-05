//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Luis Filipe Pedroso on 29/08/25.
//

import SwiftUI

@main
struct CryptoApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .toolbar(.hidden)
            }
            .environmentObject(vm)
        }
    }
}
