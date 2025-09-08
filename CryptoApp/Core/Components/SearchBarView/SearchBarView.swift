//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by Luis Filipe Pedroso on 08/09/25.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
            
            TextField("Search by name of symbol...", text: $searchText)
                .foregroundStyle(Color.theme.accent)
                .focused($isFocused)
                .autocorrectionDisabled(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 12)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .animation(.easeInOut(duration: 0.3), value: searchText.isEmpty)
                        .onTapGesture {
                            searchText = ""
                            isFocused = false
                        }
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.15),
                    radius: 4, x: 0, y: 0
                )
        )
        .padding()
    }
}

#Preview("Light Mode", traits: .sizeThatFitsLayout) {
    SearchBarView(searchText: .constant(""))
}

#Preview("Dark Mode", traits: .sizeThatFitsLayout) {
    SearchBarView(searchText: .constant(""))
        .preferredColorScheme(.dark)
}
