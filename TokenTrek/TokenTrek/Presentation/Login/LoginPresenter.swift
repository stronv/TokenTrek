//
//  LoginPresenter.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 30.05.2023.
//

import Foundation
import Firebase

protocol LoginPresenterProtocol {
    func signIn(email: String, password: String, completion: @escaping(SignInResult) -> Void)

}

final class LoginPresenter: LoginPresenterProtocol {
    private let moduleOutput: LoginCoordinatorProtocol
    private weak var view: LoginViewProtocol?
    
    init(_ moduleOutput: LoginCoordinatorProtocol, view: LoginViewProtocol) {
        self.moduleOutput = moduleOutput
        self.view = view
    }
    
    private let firebaseService = FirebaseService.shared()
    
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
}
