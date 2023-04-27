//
//  DetailViewController.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 24.04.2023.
//

import UIKit
import Charts
import SnapKit

protocol DetailViewControllerProtocol: AnyObject {}

class DetailViewController: UIViewController, DetailViewControllerProtocol {
    
    var coin: Coin?
    
    //MARK: - UI
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.textColor = UIColor.gray
        return label
    }()
    
    private var chartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .systemBlue
        return chartView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.layer.cornerRadius = 17
        label.layer.masksToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    let nameAndPriceStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .leading
        
        return stackview
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        makeConstraints()
        configure()
    }
    
    //MARK: - Private methods
    
    private func configure() {
        nameLabel.text = coin?.name
        priceLabel.text = coin?.currentPrice.asCurrencyWith6Decimals()
        priceChangeLabel.text = coin?.priceChangePercentage24H?.asPercentString()
        
        //TODO: Move it somewhere?
        if coin?.priceChangePercentage24H ?? 0 >= 0 {
            priceChangeLabel.backgroundColor = UIColor.greenBackground
            priceChangeLabel.textColor = UIColor.green
        } else {
            priceChangeLabel.backgroundColor = UIColor.redBackground
            priceChangeLabel.textColor = UIColor.red
        }
    }
    
    private func addSubviews() {
        nameAndPriceStackView.addArrangedSubview(nameLabel)
        nameAndPriceStackView.addArrangedSubview(priceLabel)
        
        view.addSubview(nameAndPriceStackView)
        view.addSubview(priceChangeLabel)
        view.addSubview(chartView)
    }
    
    private func makeConstraints() {
        
        view.backgroundColor = .clear
        
        nameAndPriceStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(43)
            make.leading.equalToSuperview().inset(20)
        }
        
        priceChangeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(43)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(73)
            make.height.equalTo(32)
        }
        
        chartView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            
            make.topMargin.equalTo(nameAndPriceStackView.snp.top).inset(56)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(256)
            
        }
    }
}

extension DetailViewController: ChartViewDelegate {
    func chartValueSelected(
        _ chartView: ChartViewBase,
        entry: ChartDataEntry,
        highlight: Highlight
    ) {
        print(entry)
    }
}
