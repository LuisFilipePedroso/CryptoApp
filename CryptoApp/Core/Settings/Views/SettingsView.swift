//
//  SettingsView.swift
//  CryptoApp
//
//  Created by Luis Filipe Pedroso on 19/09/25.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let defaultURL = URL(string: "https://google.com")!
    let youtubeURL = URL(string: "https://youtube.com/c/dogcodedev")!
    let devToURL = URL(string: "https://dev.to/luisfpedroso")!
    let coingeckoURL = URL(string: "https://coingecko.com")!
    let personalURL = URL(string: "https://luisfpedroso.com")

    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                
                List {
                    DescriptionWithLinksSection
                    CoinGeckoSection
                }
            }
            .scrollContentBackground(.hidden)
            .disabled(true)
            .font(.headline)
            .tint(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CloseButton(onPress: {
                        presentationMode.wrappedValue.dismiss()
                    })
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}

extension SettingsView {
    
    private var DescriptionWithLinksSection: some View {
        Section(header: Text("Details")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 72, height: 72)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                Text("A great app for those who want to track their favorite cryptocurrencies. It uses MVVM Architecture, Combine, and CoreData!")
                    .font(.callout)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Subscribe on YouTube 🥳", destination: youtubeURL)
            Link("Read my content on dev.to", destination: devToURL)
        }
        .listRowBackground(Color.theme.background.opacity(0.5))
    }
    
    private var CoinGeckoSection: some View {
        Section(header: Text("CoinGecko")) {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 72)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                Text("The cryptocurrency data that is used in this app comes from CoinGecko. Prices may be slightly delayed.")
                    .font(.callout)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit CoinGecko 🥳", destination: coingeckoURL)
        }
        .listRowBackground(Color.theme.background.opacity(0.5))
    }
}
