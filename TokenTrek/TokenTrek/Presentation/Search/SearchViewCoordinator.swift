//
//  SearchViewCoordinator.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 21.05.2023.
//

import UIKit

protocol SearchViewCoordinatorProtocol: Coordinator {
    func goToCoinDetail(coin: Coin)
    func toCurrencyList()
}

class SearchViewCoordinator: SearchViewCoordinatorProtocol {
    var navigationController = UINavigationController()
    var appCoordinator: AppCoordinator?
    
    init() {
        let controller = SearchViewController()
        controller.output = SearchViewPresenter(self, view: controller)
        let navigationController = UINavigationController(rootViewController: controller)
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        return navigationController
    }
    
    func goToCoinDetail(coin: Coin) {
        let controller = DetailViewController()
        controller.configure(coin: coin)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func toCurrencyList() {
        appCoordinator?.goToMainPage()
    }
}
