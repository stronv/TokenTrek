//
//  CurrencyListPresenter.swift
//  TokenTrek
//
//  Created by Artyom Mitrofanov on 13.04.2023.
//

import Foundation

protocol CurrencyListPresenterProtocol {
    
}

class CurrencyListPresenter: CurrencyListPresenterProtocol {
    private let moduleOutput: CurrencyListCoordinatorProtocol
    private weak var view: CurrencyListViewProtocol?
    
    init(_ moduleOutput: CurrencyListCoordinatorProtocol, view: CurrencyListViewProtocol) {
        self.moduleOutput = moduleOutput
        self.view = view
    }
}
