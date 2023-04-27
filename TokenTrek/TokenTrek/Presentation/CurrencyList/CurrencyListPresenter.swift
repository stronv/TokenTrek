//
//  CurrencyListPresenter.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 13.04.2023.
//

import Foundation

protocol CurrencyListPresenterProtocol {
    func getCoinData()
}

class CurrencyListPresenter: CurrencyListPresenterProtocol {
    private let moduleOutput: CurrencyListCoordinatorProtocol
    private weak var view: CurrencyListViewProtocol?
    
    var coinDataService: CoinDataServiceProtocol = CoinDataService.shared
    var dataSource = [Coin]()
    
    init(_ moduleOutput: CurrencyListCoordinatorProtocol, view: CurrencyListViewProtocol) {
        self.moduleOutput = moduleOutput
        self.view = view
    }
    
    func getCoinData() {
        coinDataService.obtainCoins { [weak self] (result) in
            switch result {
            case .success(coins: let coins):
                self?.dataSource = coins
                DispatchQueue.main.async {
                    self?.view?.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func showCoinDetail(indexPath: IndexPath) {
        moduleOutput.goToCoinDetail(coin: dataSource[indexPath.row])
    }
}
