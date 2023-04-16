//
//  GreetingPresenter.swift
//  TokenTrek
//
//  Created by Artyom Mitrofanov on 03.04.2023.
//

import Foundation

protocol GreetingViewOutput {
    func toCreateAccount()
    func toCurrencyList()
}

class GreetingPresenter: GreetingViewOutput {
    private let moduleOutput: GreetingCoordinatorProtocol
    private weak var view: GreetingViewProtocol?
    
    init(_ moduleOutput: GreetingCoordinatorProtocol, view: GreetingViewProtocol) {
        self.moduleOutput = moduleOutput
        self.view = view
    }
    
    //GreetingModuleOutput
    func toCreateAccount() {
        moduleOutput.toCreateAccount()
    }
    
    func toCurrencyList() {
        moduleOutput.toCurrencyList()
    }
}
