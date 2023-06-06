//
//  AppCoordinator.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 03.04.2023.
//

import UIKit

class AppCoordinator {
    
    var window = UIWindow()
    
    func goToGreetingPage() {
        window.makeKeyAndVisible()
        window.backgroundColor = .systemBackground
        let coordinator = GreetingCoordinator()
        coordinator.appCoordinator = self
        setRootViewController(coordinator.start(), duration: 0.3)
    }
    
    func goToMainPage() {
        let coordinator = CurrencyListCoordinator()
        coordinator.appCoordinator = self
        setRootViewController(coordinator.start(), duration: 0.3)
    }
    
    func goToRegistrationPage() {
        let coordinator = RegistrationCoordinator()
        coordinator.appCoordinator = self
        setRootViewController(coordinator.start(), duration: 0.3)
    }
    
    func goToSearchPage() {
        let coordinator = SearchViewCoordinator()
        coordinator.appCoordinator = self
        setRootViewController(coordinator.start(), duration: 0.3)
    }
    
    func goToLoginPage() {
        let coordinator = LoginCoordinator()
        coordinator.appCoordinator = self
        setRootViewController(coordinator.start(), duration: 0.3)
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
