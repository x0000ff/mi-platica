//
//  NumberFormatter.swift
//  MiPlatica
//
//  Created by Konstantin Portnov on 12/20/18.
//  Copyright © 2018 x0000ff. All rights reserved.
//

//############################################################
import Foundation

//############################################################
extension NumberFormatter {
    
    //--------------------------------------------------------
    static func createDefaultCurrencyFormatter() -> NumberFormatter {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        formatter.currencySymbol = "$ "
        
        return formatter
    }

    //--------------------------------------------------------
}

//############################################################
extension NumberFormatter {
    
    //--------------------------------------------------------
    static func formatCurrency(amount: Any?) -> String? {
        
        guard let formatted = NumberFormatter.createDefaultCurrencyFormatter().string(for: amount) else {
            return nil
        }
        
        return "$ "  + formatted
    }

    //--------------------------------------------------------
}

//############################################################
