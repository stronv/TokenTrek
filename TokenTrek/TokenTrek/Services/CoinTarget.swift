//
//  CoinTarget.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 27.04.2023.
//

import Moya

enum CoinTarget {
    case getCoins
}

extension CoinTarget: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.coingecko.com") else { fatalError("Could not get URL") }
        return url
    }
    var path: String {
        switch self {
        case .getCoins:
            return "/api/v3/coins/markets"
        }
    }
    var method: Moya.Method {
        .get
    }
    var task: Moya.Task {
        .requestParameters(parameters: [
            "vs_currency": "usd",
            "order": "market_cap_desc",
            "per_page": 250,
            "page": 1,
            "sparkline": "true",
            "price_change_percentage": "24h",
            "locale": "en"
        ], encoding: URLEncoding.default)
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
