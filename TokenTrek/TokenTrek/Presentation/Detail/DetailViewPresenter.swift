//
//  DetailViewPresenter.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 01.06.2023.
//

import Foundation

enum AuthStatus {
    case isAuthorized
    case isNonauthorized
}

enum CoinIsFavorite {
    case addCoinToFavorite
    case removeCoinFromFavorite
}

protocol DetailViewOutput {
    func viewDidLoadEvent()
    func watchListOperation(isFavorite: CoinIsFavorite)
}

final class DetailViewPresenter: DetailViewOutput {
    
    private weak var view: DetailViewControllerProtocol?
    var coin: Coin
    
    var favoriteCoins: [String] = []
    
    private let firebaseService = FirebaseService.shared
        
    init(view: DetailViewControllerProtocol, coin: Coin) {
        self.view = view
        self.coin = coin
    }

    private func getFavoriteCoins() {
        firebaseService.getFavoriteCoins(comletion: { [weak self] favoriteCoins in
            self?.favoriteCoins = favoriteCoins
        })
    }
    
    private func checkIfUidExists() {
        if let _ = UserDefaults.standard.object(forKey: "uid") as? String {
            view?.updateViewState(state: .isAuthorized)
        } else {
            view?.updateViewState(state: .isNonauthorized)
        }
    }
    
    private func updateFavoriteButton() {
        if favoriteCoins.contains(coin.id) {
            view?.setFavoriteButtonSelected(isSelected: true)
        } else {
            view?.setFavoriteButtonSelected(isSelected: false)
        }
    }
    
    private func addCoinToFavorite() {
        if !favoriteCoins.contains(coin.id) {
            favoriteCoins.append(coin.id)
            firebaseService.updateFavoriteCoins(favoriteCoins)
        }
    }
    
    private func removeCoinFromFavorite() {
        if let index = favoriteCoins.firstIndex(of: coin.id) {
            favoriteCoins.remove(at: index)
            firebaseService.updateFavoriteCoins(favoriteCoins)
        }
    }
}

// MARK: - Public methods
extension DetailViewPresenter {
    func viewDidLoadEvent() {
        checkIfUidExists()
        getFavoriteCoins()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.updateFavoriteButton()
        }
    }
    
    func watchListOperation(isFavorite: CoinIsFavorite) {
        switch isFavorite {
        case .removeCoinFromFavorite:
            removeCoinFromFavorite()
            removeCoinFromFavorite()
        case .addCoinToFavorite:
            addCoinToFavorite()
        }
    }
}
