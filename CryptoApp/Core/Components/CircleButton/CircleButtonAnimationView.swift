//
//  CircleButtonAnimationView.swift
//  CryptoApp
//
//  Created by Luis Filipe Pedroso on 03/09/25.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @State private var animate: Bool = false
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5)
            .scale(animate ? 1 : 0)
            .opacity(animate ? 0 : 1)
            .animation(.easeOut(duration: 1), value: animate)
            .onAppear {
                animate.toggle()
            }
    }
}

#Preview {
    CircleButtonAnimationView()
}
