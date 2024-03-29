//
//  LoginPresenter.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 30.05.2023.
//

import Foundation
import Firebase

protocol LoginViewOutput {
    func signIn(email: String, password: String, completion: @escaping(SignInResult) -> Void)
    func showGreetingPage()
    func showRegistration()
    func showMainPage()
    func viewDidLoadEvent()
    func showCurrencyList()

}

final class LoginPresenter: LoginViewOutput {
    private let moduleOutput: LoginCoordinatorProtocol
    private weak var view: LoginViewProtocol?
    
    init(_ moduleOutput: LoginCoordinatorProtocol, view: LoginViewProtocol) {
        self.moduleOutput = moduleOutput
        self.view = view
    }
    
    private let firebaseService = FirebaseService.shared
    
    private func checkIfUidExists() {
        if let _ = UserDefaults.standard.object(forKey: "uid") as? String {
            view?.checkAuthState(state: .isAuthorized)
        } else {
            view?.checkAuthState(state: .isNonauthorized)
        }
    }
}

extension LoginPresenter {
    func viewDidLoadEvent() {
        checkIfUidExists()
    }
    
    func signIn(email: String, password: String, completion: @escaping(SignInResult) -> Void) {
        firebaseService.signIn(
            email: email,
            password: password
        ) { result in
            switch result {
            case .succes:
                self.moduleOutput.toCurrencyList()
            case .failure:
                print("Login failure")
            }
        }
    }
    
    func showGreetingPage() {
        moduleOutput.toGreetingPage()
    }
    
    func showRegistration() {
        moduleOutput.toSignUp()
    }
    
    func showMainPage() {
        firebaseService.signOut()
        moduleOutput.toCurrencyList()
    }
    
    func showCurrencyList() {
        moduleOutput.toCurrencyList()
    }
}
