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
    func updateCurrencyListState(_ state: CurrencyListState)
}

class CurrencyListViewController: UIViewController, CurrencyListViewProtocol {
    // MARK: - UI
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let errorView: ErrorView = {
        let view = ErrorView()
        view.isHidden = true
        return view
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
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        button.addTarget(self, action: #selector(marketCapRankButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let marketCapButton: UIButton = {
        let button = UIButton()
        button.setTitle("market cap", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.ubuntuRegular, size: 14)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.gray, for: .normal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        button.addTarget(self, action: #selector(marketCapButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let priceButton: UIButton = {
        let button = UIButton()
        button.setTitle("price (USD)", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.ubuntuRegular, size: 14)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.gray, for: .normal)
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
        button.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        button.addTarget(self, action: #selector(priceButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let priceChangePercentageButton: UIButton = {
        let button = UIButton()
        button.setTitle("24h.%", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.ubuntuRegular, size: 14)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.gray, for: .normal)
        button.addTarget(self, action: #selector(priceChangePercentageButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let filterButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    //TODO: Move it to ErrorView?
    private let refreshPageButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.blueButton
        button.setTitle("Перезагрузить", for: .normal)
        button.addTarget(self, action: #selector(refreshPageButtonAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - MVP Properties
    var output: CurrencyListPresenterProtocol!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setConstraints()
        output.viewDidLoadEvent()
        tableViewSetup()
    }
    
    //MARK: - Private Methods
    private func addSubviews() {
        filterButtonsStackView.addArrangedSubview(marketCapRankButton)
        filterButtonsStackView.addArrangedSubview(marketCapButton)
        filterButtonsStackView.addArrangedSubview(priceButton)
        filterButtonsStackView.addArrangedSubview(priceChangePercentageButton)
        
        errorView.addSubview(refreshPageButton)
        
        view.addSubview(filterButtonsStackView)
        view.addSubview(tableView)
        view.addSubview(errorView)
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
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        errorView.snp.makeConstraints { make in
            make.top.equalTo(marketCapRankButton.snp_bottomMargin).offset(12)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        refreshPageButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func tableViewSetup() {
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: "CurrencyTableViewCell")
        tableView.backgroundColor = .clear
        tableView.separatorColor = UIColor.clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
    }
    
    //MARK: - Objc Methods
    @objc func refresh(_ sender: AnyObject) {
        output.reloadData()
        sender.endRefreshing()
    }
    
    private var marketCapRankButtonIsToggled: Bool = false
    
    @objc func marketCapRankButtonAction() {
        if marketCapRankButtonIsToggled == false {
            marketCapRankButton.setTitleColor(UIColor.blackButton, for: .normal)
            output.sortCoins(sort: .marketCapReversed)
            marketCapRankButtonIsToggled = true
            tableView.reloadData()
        } else {
            marketCapRankButton.setTitleColor(UIColor.gray, for: .normal)
            output.sortCoins(sort: .marketCap)
            marketCapRankButtonIsToggled = false
            tableView.reloadData()
        }
    }
    
    private var marketCapButtonIsToggled: Bool = false
    
    @objc func marketCapButtonAction() {
        if marketCapButtonIsToggled == false {
            marketCapButton.setTitleColor(UIColor.blackButton, for: .normal)
            output.sortCoins(sort: .marketCapReversed)
            marketCapButtonIsToggled = true
            tableView.reloadData()
        } else {
            marketCapButton.setTitleColor(UIColor.gray, for: .normal)
            output.sortCoins(sort: .marketCap)
            marketCapButtonIsToggled = false
            tableView.reloadData()
        }
    }
    
    private var priceButtonIsToggled: Bool = false
    
    @objc func priceButtonAction() {
        if priceButtonIsToggled == false {
            priceButton.setTitleColor(UIColor.blackButton, for: .normal)
            output.sortCoins(sort: .priceReversed)
            priceButtonIsToggled = true
            tableView.reloadData()
        } else {
            priceButton.setTitleColor(UIColor.gray, for: .normal)
            output.sortCoins(sort: .price)
            priceButtonIsToggled = false
            tableView.reloadData()
        }
    }
    
    private var precentChangeIsToggled: Bool = false
    
    @objc func priceChangePercentageButtonAction() {
        if precentChangeIsToggled == false {
            priceChangePercentageButton.setTitleColor(UIColor.blackButton, for: .normal)
            output.sortCoins(sort: .changeInPercentReversed)
            precentChangeIsToggled = true
            tableView.reloadData()
        } else {
            priceChangePercentageButton.setTitleColor(UIColor.gray, for: .normal)
            output.sortCoins(sort: .changeInPercent)
            precentChangeIsToggled = false
            tableView.reloadData()
        }
    }
    
    @objc func refreshPageButtonAction() {
        output.reloadData()
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension CurrencyListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return output.coins.count
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
        let moneta = output.coins[indexPath.row]
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

//MARK: - Publich Methods
extension CurrencyListViewController {
    func updateCurrencyListState(_ state: CurrencyListState) {
        switch state {
        case .data:
            tableView.isHidden = false
            filterButtonsStackView.isHidden = false
            errorView.isHidden = true
            
        case .error:
            tableView.isHidden = true
            filterButtonsStackView.isHidden = true
            errorView.isHidden = false
        }
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}


