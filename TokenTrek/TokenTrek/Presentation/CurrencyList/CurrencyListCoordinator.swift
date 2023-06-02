//
//  CurrencyListCoordinator.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 13.04.2023.
//

import UIKit

protocol CurrencyListCoordinatorProtocol: Coordinator {
    func goToCoinDetail(coin: Coin)
    func goToSearchView()
}

class CurrencyListCoordinator: CurrencyListCoordinatorProtocol {
    var navigationController = UINavigationController()
    var appCoordinator: AppCoordinator?
    
    init() {
        let controller = CurrencyListViewController()
        controller.output = CurrencyListPresenter(self, view: controller)
        let navigationController = UINavigationController(rootViewController: controller)
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        return navigationController
    }
    
    func goToCoinDetail(coin: Coin) {
        let controller = DetailViewController()
        controller.output = DetailViewPresenter(view: controller, coin: coin)
        controller.configure(coin: coin)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToSearchView() {
        appCoordinator?.goToSearchPage()
    }
}
