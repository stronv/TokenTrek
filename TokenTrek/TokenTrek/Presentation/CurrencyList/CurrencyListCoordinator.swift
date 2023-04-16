//
//  CurrencyListCoordinator.swift
//  TokenTrek
//
//  Created by Artyom Mitrofanov on 13.04.2023.
//

import UIKit

protocol CurrencyListCoordinatorProtocol: Coordinator {
    func showDetailCurrency()
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
    
    func showDetailCurrency() {
        print("show detail")
    }
}
