//
//  String.swift
//  CryptoApp
//
//  Created by Luis Filipe Pedroso on 19/09/25.
//

import Foundation

extension String {
    
    var removingHTMLOccurences: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
