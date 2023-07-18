//
//  SearchViewPresenter.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 21.05.2023.
//

import Foundation

protocol SearchViewOutput {
    var coins: [Coin] { get }
    var searchedCoins: [Coin] { get set }
    func showCoinDetail(indexPath: IndexPath)
    func showCurrencyList()
    func viewDidLoadEvent()
}

final class SearchViewPresenter: SearchViewOutput {
    
    private let moduleOutput: SearchViewCoordinatorProtocol
    private weak var view: SearchViewProtocol?

    var coins: [Coin] = []
    var searchedCoins: [Coin] = []
    
    init(_ moduleOutput: SearchViewCoordinatorProtocol, view: SearchViewProtocol) {
        self.moduleOutput = moduleOutput
        self.view = view
    }
    
    private let coreDataManager = CoreDataManager.shared
    
    private func loadCoins() {
        coins = coreDataManager.fetchCoinsFromCoreData()
        coins.sort(by: { $0.marketCapRank < $1.marketCapRank })
    }
}

extension SearchViewPresenter {
    func viewDidLoadEvent() {
        loadCoins()
    }
    
    func showCoinDetail(indexPath: IndexPath) {
        moduleOutput.goToCoinDetail(coin: searchedCoins[indexPath.row])
    }
    
    func showCurrencyList() {
        moduleOutput.toCurrencyList()
    }
}
