//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Luis Filipe Pedroso on 29/08/25.
//

import SwiftUI

@main
struct CryptoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .toolbar(.hidden)
            }
        }
    }
}
