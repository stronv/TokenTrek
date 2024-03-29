//
//  SearchViewController.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 11.05.2023.
//

import UIKit
import SnapKit

protocol SearchViewProtocol: AnyObject {
    func reloadData()
}

class SearchViewController: UIViewController, SearchViewProtocol {
    
    // MARK: - UI
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "search_text_field_placeholder".localized
        textField.backgroundColor = UIColor(named: "placeholderColor")
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clipsToBounds = false
        textField.layer.shadowOpacity = 0.1
        textField.layer.shadowOffset = CGSize(width: 0, height: 0)
        textField.layer.cornerRadius = 22
        return textField
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: "backgroundColor")
        return tableView
    }()
    
    // MARK: - MVP properties
    var output: SearchViewOutput!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        navBarSetup()
        output.viewDidLoadEvent()
        tableViewSetup()
        
        searchTextField.delegate = self
    }
    
    private struct Constants {
        static let leading: CGFloat = 20
        static let trailing: CGFloat = 20
        static let top: CGFloat = 20
    }
    
    // MARK: - Private methods
    private func setup() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().inset(Constants.leading)
            make.trailing.equalToSuperview().inset(Constants.trailing)
            make.height.equalTo(46)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(Constants.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func tableViewSetup() {
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: "CurrencyTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = UIColor.clear
    }
    
    private func createCustomButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(
            UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate),
            for: .normal
        )
        button.tintColor = UIColor(named: "mainTextFontColor")
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
    
    private func navBarSetup() {
        let backButton = createCustomButton(
            imageName: "backButtonImage",
            selector: #selector(backButtonAction)
        )
        navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK: - Objc Methods
    @objc func backButtonAction() {
        output.showCurrencyList()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate
extension SearchViewController: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection
        section: Int
    ) -> Int {
        return output.searchedCoins.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "CurrencyTableViewCell"
        ) as? CurrencyTableViewCell
        else {
            fatalError("Couldn't register cell")
        }
        let moneta = output.searchedCoins[indexPath.row]
        cell.backgroundColor = .clear
        cell.configure(coin: moneta)
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        output.showCoinDetail(indexPath: indexPath)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        searchTextField.text = ""
        self.output.searchedCoins = self.output.coins
        tableView.reloadData()
        return false
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let searchText = textField.text?.lowercased(), !searchText.isEmpty {
            self.output.searchedCoins.removeAll()
            for coin in output.coins {
                if coin.symbol.lowercased().hasPrefix(searchText) || coin.name.lowercased().hasPrefix(searchText) {
                    self.output.searchedCoins.append(coin)
                }
            }
        } else {
            self.output.searchedCoins = self.output.coins
        }
        tableView.reloadData()
        return true
    }

}

// MARK: - Public Methods
extension SearchViewController {
    func reloadData() {
        tableView.reloadData()
    }
}
