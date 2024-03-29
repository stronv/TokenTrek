//
//  GreetingCoordinator.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 03.04.2023.
//

import UIKit

protocol GreetingCoordinatorProtocol: Coordinator {
    func toCreateAccount()
    func toCurrencyList()
    func toSignIn()
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
        appCoordinator?.goToRegistrationPage()
    }
    
    func toCurrencyList() {
        appCoordinator?.goToMainPage()
    }
    
    func toSignIn() {
        appCoordinator?.goToLoginPage()
    }
}
