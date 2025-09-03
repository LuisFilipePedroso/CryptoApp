//
//  HomeView.swift
//  CryptoApp
//
//  Created by Luis Filipe Pedroso on 29/08/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    if showPortfolio {
                        CircleButtonView(icon: "plus", width: 40, height: 40)
                        .transaction { $0.disablesAnimations = true }
                            .matchedGeometryEffect(id: "portfolio", in: namespace)
                            
                    } else {
                        CircleButtonView(icon: "info", width: 40, height: 40)
                        .transaction { $0.disablesAnimations = true }
                            .matchedGeometryEffect(id: "portfolio", in: namespace)
                            
                    }
                    
                    Spacer()
                    
                    Text(showPortfolio ? "Portfolio" : "Live prices")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.theme.accent)
                        .transaction { $0.disablesAnimations = true }
                    
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
                Spacer(minLength: 0)
            }
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
            .toolbar(.hidden)
    }
}
