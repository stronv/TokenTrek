//
//  Double.swift
//  TokenTrek
//
//  Created by Artyom Mitrofanov on 16.04.2023.
//

import Foundation

extension Double {
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    func aNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    func asPercentString() -> String {
        return aNumberString() + "%"
    }
    
    func convertToCurrency() -> String {
        let num = Int(self)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = "."
        formatter.maximumFractionDigits = 1
        if num >= 1000000000 {
            return formatter.string(from: NSNumber(value: Double(num/100000000)/10.0))! + " Bn"
        }
        else if num >= 1000000 {
            return formatter.string(from: NSNumber(value: Double(num/100000)/10.0))! + " M"
        }
        else {
            return formatter.string(from: NSNumber(value: self))!
        }
    }
}
