//
//  LoginCoordinator.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 31.05.2023.
//

import UIKit

protocol LoginCoordinatorProtocol: Coordinator {
    func toSignUp()
    func toCurrencyList()
    func toGreetingPage()
}

class LoginCoordinator: LoginCoordinatorProtocol {
    
    var navigationController = UINavigationController()
    var appCoordinator: AppCoordinator?
    
    init() {
        let controller = LoginViewController()
        controller.output = LoginPresenter(self, view: controller)
        let navigationController = UINavigationController(rootViewController: controller)
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        return navigationController
    }
    
    func toSignUp() {
        appCoordinator?.goToRegistrationPage()
    }
    
    func toCurrencyList() {
        appCoordinator?.goToMainPage()
    }
    
    func toGreetingPage() {
        appCoordinator?.goToGreetingPage()
    }
}
