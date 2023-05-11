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
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 10)
        label.textColor = UIColor.gray
        return label
    }()
    
    private var lineChartView: LineChartView = {
        let chart = LineChartView()
        chart.backgroundColor = .clear
        chart.rightAxis.enabled = false
        chart.xAxis.enabled = false
        chart.animate(xAxisDuration: 3.0)
        chart.doubleTapToZoomEnabled = false
        
        let yAxis = chart.leftAxis

        yAxis.labelTextColor = .black
        yAxis.axisLineColor = .systemGray
        yAxis.drawLabelsEnabled = false

        return chart
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 14)
        label.textColor = .black
        return label
    }()
    
    let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 14)
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
        
        setData()
        
        lineChartView.delegate = self
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
        view.addSubview(lineChartView)
    }
    
    private func makeConstraints() {
        view.backgroundColor = .white
        
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
        
        lineChartView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            
            make.topMargin.equalTo(nameAndPriceStackView.snp.top).inset(56)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(256)
        }
    }
    
    //MARK: - Chart Methods
    private func setData() {
        var priceData: [ChartDataEntry] = []
        guard let prices = coin?.sparklineIn7D?.price else { return }
        
        for (x, y) in prices.enumerated() {
            priceData.append(ChartDataEntry(x: Double(x), y: Double(y)))
        }
        let set = LineChartDataSet(entries: priceData, label: "\(coin!.symbol.uppercased()) price")
        set.setColor(UIColor.green)
        set.highlightColor = .systemGray
        set.lineWidth = 2
        set.highlightLineWidth = 1
        set.drawCirclesEnabled = false
        
        let data = LineChartData(dataSet: set)
        
        lineChartView.data = data
        
        let customMarkerView = CustomMarkerView()
        
        customMarkerView.chartView = lineChartView
        lineChartView.marker = customMarkerView
        
    }
}

extension DetailViewController: ChartViewDelegate {
    func chartValueSelected(
        _ chartView: ChartViewBase,
        entry: ChartDataEntry,
        highlight: Highlight
    ) {
        priceLabel.text = entry.y.asCurrencyWith6Decimals()
    }
}
