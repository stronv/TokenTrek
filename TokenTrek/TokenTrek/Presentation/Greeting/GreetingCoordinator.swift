//
//  GreetingCoordinator.swift
//  TokenTrek
//
//  Created by Artyom Mitrofanov on 03.04.2023.
//

import UIKit

protocol GreetingCoordinatorProtocol: Coordinator {
    func toCreateAccount()
    func toCurrencyList()
}

class GreetingCoordinator: GreetingCoordinatorProtocol {
    var navigationController = UINavigationController()
    var appCoordinator: AppCoordinator?
    
    init() {
        let controller = GreetingViewController()
        controller.output = GreetingPresenter(self, view: controller)
        let navigationController = UINavigationController(rootViewController: controller)
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        return navigationController
    }
    
    func toCreateAccount() {
        //TODO: Add Coordinator here ??
        let controller = RegistrationViewController()
        navigationController.pushViewController(controller, animated: true)
    }
    
    func toCurrencyList() {
        appCoordinator?.goToMainPage()
    }
}
