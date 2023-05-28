//
//  CurrencyListPresenter.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 13.04.2023.
//

import Foundation

protocol CurrencyListPresenterProtocol {
    var coins: [Coin] { get }
    func showCoinDetail(indexPath: IndexPath)
    func showSearchView()
    func viewDidLoadEvent()
    func reloadData()
    func sortCoins(sort: SortOption)
}

enum SortOption {
    case rank, rankReversed
    case marketCap, marketCapReversed
    case price, priceReversed
    case changeInPercent, changeInPercentReversed
}

final class CurrencyListPresenter: CurrencyListPresenterProtocol {
    
    private let moduleOutput: CurrencyListCoordinatorProtocol
    private weak var view: CurrencyListViewProtocol?
        
    init(_ moduleOutput: CurrencyListCoordinatorProtocol, view: CurrencyListViewProtocol) {
        self.moduleOutput = moduleOutput
        self.view = view
    }
    
    var coins: [Coin] = []
    private let networkManager: NetworkManager = NetworkManager()
    private let coreDataManager = CoreDataManager.shared()
    
    private func loadCoins() {
        networkManager.fetchCoins { [weak self] (result) in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let response):
                weakSelf.coreDataManager.prepare(dataForSaving: response)
//                print(response.first?.currentPrice)
                weakSelf.coins = weakSelf.coreDataManager.fetchCoinsFromCoreData()
                weakSelf.coins.sort(by: { $0.marketCapRank < $1.marketCapRank })
                weakSelf.view?.updateCurrencyListState(.data)
                weakSelf.view?.reloadData()
            case .failure(let error):
                weakSelf.coins = weakSelf.coreDataManager.fetchCoinsFromCoreData()
                weakSelf.view?.updateCurrencyListState(.error)
                weakSelf.coins.sort(by: { $0.marketCapRank < $1.marketCapRank })
                weakSelf.view?.reloadData()
                print(error)
            }
        }
    } 
}

extension CurrencyListPresenter {
    func viewDidLoadEvent() {
        loadCoins()
    }
    
    func reloadData() {
        loadCoins()
    }
    
    func showCoinDetail(indexPath: IndexPath) {
        moduleOutput.goToCoinDetail(coin: coins[indexPath.row])
    }
    
    func showSearchView() {
        moduleOutput.goToSearchView()
    }
    
    func sortCoins(sort: SortOption) {
        switch sort {
        case .rank, .marketCap:
            coins = coins.sorted(by: { $0.marketCapRank < $1.marketCapRank })
        case .rankReversed, .marketCapReversed:
            coins = coins.sorted(by: { $0.marketCapRank > $1.marketCapRank })
        case .price:
            coins = coins.sorted(by: { $0.currentPrice > $1.currentPrice })
        case .priceReversed:
            coins = coins.sorted(by: { $0.currentPrice < $1.currentPrice })
        case .changeInPercent:
            coins = coins.sorted(by: { $0.priceChangePercentage24H ?? 0 > $1.priceChangePercentage24H ?? 0 })
        case .changeInPercentReversed:
            coins = coins.sorted(by: { $0.priceChangePercentage24H ?? 0 < $1.priceChangePercentage24H ?? 0  })
        }
    }
}
