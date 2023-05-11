//
//  NetworkManager.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 27.04.2023.
//

import Moya

protocol NetworkManagerProtocol {
    func fetchCoins(completion: @escaping (Result<[Coin], Error>) -> ())
}

final class NetworkManager: NetworkManagerProtocol {
    private var provider = MoyaProvider<CoinTarget>()
    func fetchCoins(completion: @escaping (Result<[Coin], Error>) -> ()) {
        request(target: .getCoins, completion: completion)
    }
}

private extension NetworkManager {
    private func request<T: Decodable>(target: CoinTarget, completion: @escaping (Result<T, Error>) ->()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let.failure(error):
                completion(.failure(error))
            }
        }
    }
}
