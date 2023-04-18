//
//  CoinDataService.swift
//  TokenTrek
//
//  Created by Artyom Mitrofanov on 16.04.2023.
//

import Foundation

enum ObtainCoinResult {
    case success(coins: [Coin])
    case failure(error: Error)
}

protocol CoinDataServiceProtocol {
    func obtainCoins(completion: @escaping(ObtainCoinResult) -> Void)
}

class CoinDataService: CoinDataServiceProtocol {
    
    static let shared: CoinDataService = .init()
    
    let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    func obtainCoins(completion: @escaping(ObtainCoinResult) -> Void) {
        guard
            let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=en")
        else { return }
        session.dataTask(with: url) {
            [weak self] (data, responce, error) in
            
            guard let strongSelf = self else { return }
            var result: ObtainCoinResult
            
            defer {
                DispatchQueue.main.async { completion(result) }
                print("Data was requested")
            }
            if error == nil, let parseData = data {
                guard
                    let coins = try? strongSelf.decoder.decode([Coin].self, from: parseData)
                else {
                    result = .success(coins: [])
                    return
                }
                result = .success(coins: coins)
            } else {
                result = .failure(error: error!)
            }
        }.resume()
    }
}
