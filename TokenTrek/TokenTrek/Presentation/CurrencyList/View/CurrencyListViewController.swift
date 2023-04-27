//
//  CurrencyListViewController.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 07.04.2023.
//

import UIKit
import SnapKit

protocol CurrencyListViewProtocol: AnyObject {
    func reloadData()
}

class CurrencyListViewController: UIViewController, CurrencyListViewProtocol {
    // MARK: - UI
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: "CurrencyTableViewCell")
        tableView.backgroundColor = .clear
        tableView.separatorColor = UIColor.clear
        return tableView
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    private let marketCapRankButton: UIButton = {
        let button = UIButton()
        button.setTitle("#", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.ubuntuRegular, size: 14)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.gray, for: .normal)
        button.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        button.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        return button
    }()
    
    private let marketCapButton: UIButton = {
        let button = UIButton()
        button.setTitle("market cap", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.ubuntuRegular, size: 14)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.gray, for: .normal)
        button.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        button.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        return button
    }()
    
    private let priceButton: UIButton = {
        let button = UIButton()
        button.setTitle("price (USD)", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.ubuntuRegular, size: 14)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.gray, for: .normal)
        button.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        button.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        return button
    }()
    
    private let priceChangePercentageButton: UIButton = {
        let button = UIButton()
        button.setTitle("24h.%", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.ubuntuRegular, size: 14)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.gray, for: .normal)
        return button
    }()
    
    private let filterButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    //MARK: - MVP Properties
    var output: CurrencyListPresenter!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setConstraints()
        
        tableView.refreshControl = refreshControl
        
        output.getCoinData()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    //MARK: - Private Methods
    private func addSubviews() {
        filterButtonsStackView.addArrangedSubview(marketCapRankButton)
        filterButtonsStackView.addArrangedSubview(marketCapButton)
        filterButtonsStackView.addArrangedSubview(priceButton)
        filterButtonsStackView.addArrangedSubview(priceChangePercentageButton)
        
        view.addSubview(filterButtonsStackView)
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        view.backgroundColor = .white
        filterButtonsStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(marketCapRankButton.snp_bottomMargin).offset(12)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
        
    //MARK: - Objc Methods
    @objc func refresh(_ sender: AnyObject) {
        output.getCoinData()
        sender.endRefreshing()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension CurrencyListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return output.dataSource.count
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
        
        let moneta = output.dataSource[indexPath.row]
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
}
 
