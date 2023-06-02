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

protocol DetailViewPresenterProtocol {
    func addCoinToFavorite()
    func viewDidLoadEvent()
}

class DetailViewPresenter: DetailViewPresenterProtocol {
    
    private weak var view: DetailViewControllerProtocol?
    var coin: Coin
    
    var favoriteCoins: [String] = []
    
    private let firebaseService = FirebaseService.shared()
        
    init(view: DetailViewControllerProtocol, coin: Coin) {
        self.view = view
        self.coin = coin
        
        print("init")
        
        firebaseService.getFavoriteCoins(comletion: { [weak self] favoriteCoins in
            self?.favoriteCoins = favoriteCoins
            print("completion")
        })
    }
    
    func addCoinToFavorite() {
        if !favoriteCoins.contains(coin.id) {
            favoriteCoins.append(coin.id)
            firebaseService.updateFavoriteCoins(favoriteCoins)
        }
    }
    
    func viewDidLoadEvent() {
        checkIfUidExists()
    }
    
    func checkIfUidExists() -> Bool {
        if let _ = UserDefaults.standard.object(forKey: "uid") as? String {
            view?.updateViewState(state: .isAuthorized)
            return true
        } else {
            view?.updateViewState(state: .isNonauthorized)
            return false
        }
    }
}
