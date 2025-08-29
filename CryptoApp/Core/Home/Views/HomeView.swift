//
//  HomeView.swift
//  CryptoApp
//
//  Created by Luis Filipe Pedroso on 29/08/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                Text("Header")
                Spacer(minLength: 10)
            }
        }
    }
}

#Preview {
    HomeView()
}
