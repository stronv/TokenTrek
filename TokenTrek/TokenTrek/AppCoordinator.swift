//
//  AppCoordinator.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 03.04.2023.
//

import UIKit

class AppCoordinator {
    
    var window = UIWindow()
    
    private lazy var greetingCoordinator: GreetingCoordinator = {
        let coordinator = GreetingCoordinator()
        coordinator.appCoordinator = self
        return coordinator
    }()
    
    private lazy var mainCoordinator: CurrencyListCoordinator = {
        let coordinator = CurrencyListCoordinator()
        coordinator.appCoordinator = self
        return coordinator
    }()
    
    private lazy var registrationCoordinator: RegistrationCoordinator = {
        let coordinator = RegistrationCoordinator()
        coordinator.appCoordinator = self
        return coordinator
    }()
    
    private lazy var loginCoordinator: LoginCoordinator = {
        let coordinator = LoginCoordinator()
        coordinator.appCoordinator = self
        return coordinator
    }()
    
    private lazy var searchCoordinator: SearchViewCoordinator = {
        let coordinator = SearchViewCoordinator()
        coordinator.appCoordinator = self
        return coordinator
    }()
    
    func goToGreetingPage() {
        window.makeKeyAndVisible()
        window.backgroundColor = .systemBackground
        setRootViewController(greetingCoordinator.start(), duration: 0.3)
    }
    
    func goToMainPage() {
        setRootViewController(mainCoordinator.start(), duration: 0.3)
    }
    
    func goToRegistrationPage() {
        setRootViewController(registrationCoordinator.start(), duration: 0.3)
    }
    
    func goToSearchPage() {
        setRootViewController(searchCoordinator.start(), duration: 0.3)
    }
    
    func goToLoginPage() {
        setRootViewController(loginCoordinator.start(), duration: 0.3)
    }
    
    func setRootViewController(_ vc: UIViewController, duration: TimeInterval) {
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: duration,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil
        )
    }
}
