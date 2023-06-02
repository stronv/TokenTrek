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
    func showSignIn()
    func reloadData()
    func sortCoins(sort: SortOption)
    func changeType(type: CurrencyListType)
}

enum SortOption {
    case rank, rankReversed
    case marketCap, marketCapReversed
    case price, priceReversed
    case changeInPercent, changeInPercentReversed
}

enum CurrencyListType {
    case watchList
    case currencyList
}

final class CurrencyListPresenter: CurrencyListPresenterProtocol {
    
    private let moduleOutput: CurrencyListCoordinatorProtocol
    private weak var view: CurrencyListViewProtocol?
        
    init(_ moduleOutput: CurrencyListCoordinatorProtocol, view: CurrencyListViewProtocol) {
        self.moduleOutput = moduleOutput
        self.view = view
    }
    
    var coins: [Coin] = []
    var favoriteCoinsId: [String] = []
    private var currentType: CurrencyListType = .currencyList
    
    private let networkManager: NetworkManager = NetworkManager()
    private let coreDataManager = CoreDataManager.shared()
    private let firebaseService = FirebaseService.shared()
    
    private func loadCoins() {
        switch currentType {
        case .currencyList:
            networkManager.fetchCoins { [weak self] (result) in
                guard let weakSelf = self else { return }
                switch result {
                case .success(let response):
                    weakSelf.coreDataManager.prepare(dataForSaving: response)
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
        case .watchList:
            firebaseService.getFavoriteCoins(comletion: { [weak self] favoriteCoins in
                self?.favoriteCoinsId = favoriteCoins
                self?.coins = self?.coins.filter { coin in
                    favoriteCoins.contains(coin.id)
                } ?? []
                self?.view?.reloadData()
            })
        }
    } 
}

extension CurrencyListPresenter {
    
    func viewDidLoadEvent() {
        checkIfUidExists()
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
    
    func showSignIn() {
        moduleOutput.goToSignIn()
    }
    
    func changeType(type: CurrencyListType) {
        currentType = type
        loadCoins()
    }
    
    func checkIfUidExists() -> Bool {
        if let _ = UserDefaults.standard.object(forKey: "uid") as? String {
            view?.checkAuthState(state: .isAuthorized)
            return true
        } else {
            view?.checkAuthState(state: .isNonauthorized)
            return false
        }
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
