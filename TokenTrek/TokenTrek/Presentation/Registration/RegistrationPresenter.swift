//
//  RegistrationPresenter.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 30.05.2023.
//

import Foundation
import Firebase

protocol RegistrationPresenterProtocol {
    func signUp(email: String?, password: String?, completion: @escaping (SignUpResult) -> Void)
    func showGreetingPage()
    func toSignIn()
}

final class RegistrationPresenter: RegistrationPresenterProtocol {
    private let moduleOutput: RegistrationCoordinatorProtocol
    private weak var view: RegistrationViewProtocol?
    
    init(_ moduleOutput: RegistrationCoordinatorProtocol, view: RegistrationViewProtocol) {
        self.moduleOutput = moduleOutput
        self.view = view
    }
    
    private let firebaseService = FirebaseService.shared
}

// MARK: - Public Methods
extension RegistrationPresenter {
    func signUp(email: String?, password: String?, completion: @escaping (SignUpResult) -> Void) {
        
        guard Validators.isFilled(email: email, password: password) else {
            completion(.failure(AuthError.notFilled))
            self.view?.updateSignUpState(.failure)
            return
        }
        
        guard let email = email, let password = password else {
            completion(.failure(AuthError.unknownError))
            self.view?.updateSignUpState(.failure)
            return
        }
        
        guard Validators.validateEmail(email) else {
            completion(.failure(AuthError.invalidEmail))
            self.view?.updateSignUpState(.failure)
            return
        }
        
        firebaseService.signUp(
            email: email,
            password: password
        ) { result in
            switch result {
            case .succes:
                self.view?.updateSignUpState(.succes)
                self.moduleOutput.toCurrencyList()
            case.failure(let error):
                self.view?.updateSignUpState(.failure)
                print(error.localizedDescription)
            }
        }
    }
    
    func showGreetingPage() {
        moduleOutput.toGreetingPage()
    }
    
    func toSignIn() {
        moduleOutput.toSigIn()
    }
    
    func showCurrencyList() {
        moduleOutput.toCurrencyList()
    }
}
