//
//  Color.swift
//  CryptoApp
//
//  Created by Luis Filipe Pedroso on 29/08/25.
//
import SwiftUI

extension Color {
   
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
    
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}

struct CatppuccinMachiattoColorTheme {
    let accent       = Color(red: 238/255, green: 212/255, blue: 159/255) // Blue (#8AADF4)
    let background   = Color(red: 36/255,  green: 39/255,  blue: 58/255)  // Base (#24273A)
    let green        = Color(red: 166/255, green: 218/255, blue: 149/255) // Green (#A6DA95)
    let red          = Color(red: 237/255, green: 135/255, blue: 150/255) // Red (#ED8796)
    let secondaryText = Color(red: 202/255, green: 211/255, blue: 245/255) // Text (#CAD3F5)
}

struct LaunchTheme {
    
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}
