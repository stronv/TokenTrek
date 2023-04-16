//
//  Currency.swift
//  TokenTrek
//
//  Created by Artyom Mitrofanov on 10.04.2023.
//

import UIKit

struct Currency {
    let id: Int
    let name: String
    let ticker: String
    let priceUSD: Int
    let volume: Double
    let image: UIImage?
    
    public static func getCurrency() -> [Currency] {
        return [
            Currency(
                id: 1,
                name: "Bitcoin",
                ticker: "BTC",
                priceUSD: 29000,
                volume: 000.00,
                image: UIImage(named: "bitcoin")
            ),
            Currency(
                id: 2,
                name: "Bitcoin",
                ticker: "BTC",
                priceUSD: 29000,
                volume: 000.00,
                image: UIImage(named: "bitcoin")
            ),
            Currency(
                id: 3,
                name: "Bitcoin",
                ticker: "BTC",
                priceUSD: 29000,
                volume: 000.00,
                image: UIImage(named: "bitcoin")
            ),            Currency(
                id: 4,
                name: "Bitcoin",
                ticker: "BTC",
                priceUSD: 29000,
                volume: 000.00,
                image: UIImage(named: "bitcoin")
            ),
            Currency(
                id: 5,
                name: "Bitcoin",
                ticker: "BTC",
                priceUSD: 29000,
                volume: 000.00,
                image: UIImage(named: "bitcoin")
            ),
            Currency(
                id: 6,
                name: "Bitcoin",
                ticker: "BTC",
                priceUSD: 29000,
                volume: 000.00,
                image: UIImage(named: "bitcoin")
            ),            Currency(
                id: 7,
                name: "Bitcoin",
                ticker: "BTC",
                priceUSD: 29000,
                volume: 000.00,
                image: UIImage(named: "bitcoin")
            ),
            Currency(
                id: 8,
                name: "Bitcoin",
                ticker: "BTC",
                priceUSD: 29000,
                volume: 000.00,
                image: UIImage(named: "bitcoin")
            ),
            Currency(
                id: 9,
                name: "Bitcoin",
                ticker: "BTC",
                priceUSD: 29000,
                volume: 000.00,
                image: UIImage(named: "bitcoin")
            ),
        ]
    }
}
