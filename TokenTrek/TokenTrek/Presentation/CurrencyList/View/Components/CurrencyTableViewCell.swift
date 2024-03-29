//
//  CurrencyTableViewCell.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 10.04.2023.
//

import UIKit
import SnapKit

class CurrencyTableViewCell: UITableViewCell {

    static let identifier = "CurrencyTableViewCell"
    // MARK: - UI
    let marketCapRankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 14)
        label.textAlignment = .center
        label.textColor = UIColor(named: "mainTextFontColor")
        return label
    }()
    
    let currencyLogoImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 14)
        label.textColor = UIColor(named: "mainTextFontColor")
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 14)
        label.textColor = UIColor(named: "mainTextFontColor")
        return label
    }()
    
    let marketCapLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 10)
        label.textColor = UIColor(named: "secondaryTextFontColor")
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
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 12
        return stackView
    }()
    
    private let tikerAndVolumeStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    }()
    
    private let priceAndChartStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 22
        return stackView
    }()
    
    private let marcketCapAndLogoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 15
        return stackView
    }()
    
    enum ButtonStateView {
        case red
        case green
        case white
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
         super.init(coder: coder)
        
        addSubviews()
        setConstraints()
     }
    
    // MARK: - Private Methods
    private func priceChangeButtonConfig(state: PercentChangeButtonState) {
        switch state {
        case .red:
            priceChangeLabel.backgroundColor = UIColor.redBackground
            priceChangeLabel.textColor = UIColor.red
        case .green:
            priceChangeLabel.backgroundColor = UIColor.greenBackground
            priceChangeLabel.textColor = UIColor.green
        case .white:
            priceChangeLabel.backgroundColor = UIColor.clear
            priceChangeLabel.textColor = UIColor.clear
        }
    }
    
    private func addSubviews() {
        stackView.addArrangedSubview(marcketCapAndLogoStackView)
        stackView.addArrangedSubview(tikerAndVolumeStackView)
        stackView.addArrangedSubview(priceAndChartStackView)
        
        marcketCapAndLogoStackView.addArrangedSubview(marketCapRankLabel)
        marcketCapAndLogoStackView.addArrangedSubview(currencyLogoImage)
        priceAndChartStackView.addArrangedSubview(priceLabel)
        priceAndChartStackView.addArrangedSubview(priceChangeLabel)
        tikerAndVolumeStackView.addArrangedSubview(nameLabel)
        tikerAndVolumeStackView.addArrangedSubview(marketCapLabel)
        
        contentView.addSubview(stackView)
    }
    
    private struct Constants {
        static let priceChangeLabelWidth: CGFloat = 73
        static let priceChangeLabelbHeight: CGFloat = 32
        
        static let marketCapRankLabelWidth: CGFloat = 27
        
        static let imageWidth: CGFloat = 32
        static let imageHeight: CGFloat = 32
    }
    
    private func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp_leadingMargin)
            make.trailing.equalTo(contentView.snp_trailingMargin)
            make.top.equalTo(contentView.snp_topMargin)
            make.bottom.equalTo(contentView.snp_bottomMargin)
        }
        currencyLogoImage.snp.makeConstraints { make in
            make.width.equalTo(Constants.imageWidth)
            make.height.equalTo(Constants.imageHeight)
        }
        priceChangeLabel.snp.makeConstraints { make in
            make.width.equalTo(Constants.priceChangeLabelWidth)
            make.height.equalTo(Constants.priceChangeLabelbHeight)
        }
        marketCapRankLabel.snp.makeConstraints { make in
            make.width.equalTo(Constants.marketCapRankLabelWidth)
        }
    }
}

// MARK: - Public methods
extension CurrencyTableViewCell {
    func configure(coin: Coin) {
        marketCapRankLabel.text = "\(coin.marketCapRank)"
        currencyLogoImage.downloaded(from: coin.image)
        nameLabel.text = coin.symbol.uppercased()
        priceLabel.text = coin.currentPrice.asCurrencyWith6Decimals()
        marketCapLabel.text = coin.marketCap?.convertToCurrency()
        priceChangeLabel.text = coin.priceChangePercentage24H?.asPercentString()
        
        if coin.priceChangePercentage24H ?? 0 >= 0 {
            priceChangeButtonConfig(state: .green)
        } else if coin.priceChangePercentage24H ?? 0 <= 0 {
            priceChangeButtonConfig(state: .red)
        } else {
            priceChangeButtonConfig(state: .white)
        }
    }
}
