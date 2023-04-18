//
//  Coin.swift
//  TokenTrek
//
//  Created by Artyom Mitrofanov on 16.04.2023.
//

import Foundation

// 2094.34

struct Coin: Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCapRank: Int
    let marketCap, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
    }
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}

//{
//  "id": "bitcoin",
//  "symbol": "btc",
//  "name": "Bitcoin",
//  "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
//  "current_price": 30283,
//  "market_cap": 586275450044,
//  "market_cap_rank": 1,
//  "fully_diluted_valuation": 636338864798,
//  "total_volume": 10747103813,
//  "high_24h": 30475,
//  "low_24h": 30225,
//  "price_change_24h": -192.18547036353993,
//  "price_change_percentage_24h": -0.63063,
//  "market_cap_change_24h": -3203380324.9693604,
//  "market_cap_change_percentage_24h": -0.54343,
//  "circulating_supply": 19347843,
//  "total_supply": 21000000,
//  "max_supply": 21000000,
//  "ath": 69045,
//  "ath_change_percentage": -56.13042,
//  "ath_date": "2021-11-10T14:24:11.849Z",
//  "atl": 67.81,
//  "atl_change_percentage": 44569.07445,
//  "atl_date": "2013-07-06T00:00:00.000Z",
//  "roi": null,
//  "last_updated": "2023-04-16T13:08:53.274Z",
//  "sparkline_in_7d": {
//    "price": [
//      27979.60682202939,
//      27958.561767014442,
//    ]
//  },
//  "price_change_percentage_24h_in_currency": -0.6306313801500626
//},
