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
    private let idLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private let currencyLogoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bitcoin")
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let volumeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .systemGray
        return label
    }()
    
    private let mockChart: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mockChart")
        return imageView
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
        stackView.spacing = 44
        return stackView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 12
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
        idLabel.text = "\(currency.id)"
        currencyLogoImage.image = currency.image
        nameLabel.text = currency.ticker
        priceLabel.text = "\(currency.priceUSD) $"
        volumeLabel.text = "\(currency.volume) Bn"
    }
    
    private func addSubviews() {
        stackView.addArrangedSubview(idLabel)
        stackView.addArrangedSubview(currencyLogoImage)
        stackView.addArrangedSubview(tikerAndVolumeStackView)
        stackView.addArrangedSubview(priceAndChartStackView)
        
        priceAndChartStackView.addArrangedSubview(priceLabel)
        priceAndChartStackView.addArrangedSubview(mockChart)
        tikerAndVolumeStackView.addArrangedSubview(nameLabel)
        tikerAndVolumeStackView.addArrangedSubview(volumeLabel)
        
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
        
        mockChart.snp.makeConstraints { make in
            make.width.equalTo(73)
            make.height.equalTo(32)
        }
    }
    
}
