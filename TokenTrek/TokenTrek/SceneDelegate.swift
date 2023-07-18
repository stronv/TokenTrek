//
//  SceneDelegate.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 19.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        self.window = window
        let coordinator = AppCoordinator()
        coordinator.window = window
    
        if UserDefaults.standard.value(forKey: "uid") == nil {
            coordinator.goToGreetingPage()
        } else {
            coordinator.goToMainPage()
        }
        
        window.makeKeyAndVisible()
    }
}
