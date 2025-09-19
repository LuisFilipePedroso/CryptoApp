//
//  Date.swift
//  CryptoApp
//
//  Created by Luis Filipe Pedroso on 18/09/25.
//

import Foundation

extension Date {
    
    init(date: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: date) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortString() -> String {
        return shortFormatter.string(from: self)
    }
}
