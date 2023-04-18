//
//  CurrencyTableViewCell.swift
//  TokenTrek
//
//  Created by Artyom Mitrofanov on 10.04.2023.
//

import UIKit
import SnapKit

class CurrencyTableViewCell: UITableViewCell {
    
    static let identifier = "CurrencyTableViewCell"
    
    // MARK: - UI
    let marketCapRankLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    let currencyLogoImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    let marketCapLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .systemGray
        return label
    }()
    
    let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
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
        stackView.spacing = 30
        return stackView
    }()
    
    private let marcketCapAndLogoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 15
        return stackView
    }()
    
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
    
    //MARK: - Private Methods
    func configure(currency: Currency) {
        marketCapRankLabel.text = "\(currency.id)"
        currencyLogoImage.image = currency.image
        nameLabel.text = currency.ticker
        priceLabel.text = "\(currency.priceUSD) $"
        marketCapLabel.text = "\(currency.volume) Bn"
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
    
    private func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp_leadingMargin)
            make.trailing.equalTo(contentView.snp_trailingMargin)
            make.top.equalTo(contentView.snp_topMargin)
            make.bottom.equalTo(contentView.snp_bottomMargin)
        }
        currencyLogoImage.snp.makeConstraints { make in
            make.width.equalTo(32)
            make.height.equalTo(32)
        }
    }
}
