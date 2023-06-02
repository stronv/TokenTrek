//
//  RegistrationCoordinator.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 31.05.2023.
//

import UIKit

protocol RegistrationCoordinatorProtocol: Coordinator {
    func toSigIn()
    func toCurrencyList()
    func toGreetingPage()
}

class RegistrationCoordinator: RegistrationCoordinatorProtocol {
    
    var navigationController = UINavigationController()
    var appCoordinator: AppCoordinator?
    
    init() {
        let controller = RegistrationViewController()
        controller.output = RegistrationPresenter(self, view: controller)
        let navigationController = UINavigationController(rootViewController: controller)
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        return navigationController
    }
    
    func toSigIn() {
        appCoordinator?.goToLoginPage()
    }
    
    func toCurrencyList() {
        appCoordinator?.goToMainPage()
    }
    
    func toGreetingPage() {
        appCoordinator?.goToGreetingPage()
    }
}
