//
//  CurrencyListViewController.swift
//  TokenTrek
//
//  Created by Artyom Mitrofanov on 07.04.2023.
//

import UIKit
import SnapKit

protocol CurrencyListViewProtocol: AnyObject {}

class CurrencyListViewController: UIViewController, CurrencyListViewProtocol {
    
    // MARK: - UI
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: "CurrencyTableViewCell")
        return tableView
    }()
    
    //MARK: - MVP Properties
    var output: CurrencyListPresenter?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setConstraints()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    //MARK: - Private Methods
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        view.backgroundColor = .white
        tableView.backgroundColor = .clear
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private let currency: [Currency] = Currency.getCurrency()
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension CurrencyListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        currency.count
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
        let moneta = currency[indexPath.row]
        cell.configure(currency: moneta)
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
