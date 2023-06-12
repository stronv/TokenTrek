//
//  CustomTitleView.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 11.05.2023.
//

import UIKit

struct CoinViewModel {
    var symbol: String
    var marketCap: String
    var image: String
}

class CustomTitleView: UIView {
    
    var coin: CoinViewModel
    
    lazy var currencyLogoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.downloaded(from: coin.image)
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 11)
        label.text = coin.symbol.uppercased()
        label.textColor = UIColor(named: "mainTextFontColor")
        return label
    }()
    
    lazy var marketCapRankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 10)
        label.textAlignment = .center
        label.text = "#\(coin.marketCap)"
        label.textColor = UIColor(named: "secondaryTextFontColor")
        return label
    }()
    
    lazy var titleStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        return stackview
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 3
        return stackView
    }()
    
    init(coin: CoinViewModel) {
        self.coin = coin
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        self.coin = CoinViewModel(symbol: "", marketCap: "", image: "")
        super.init(coder: coder)
        setup()
    }
    
    private struct Constants {
        static let labelWidth: CGFloat = 30
        static let labelbHeight: CGFloat = 20
        
        static let imageWidth: CGFloat = 32
        static let imageHeight: CGFloat = 32
    }
    
    // MARK: - Private metohds
    private func setup() {
        titleStackView.addArrangedSubview(nameLabel)
        titleStackView.addArrangedSubview(marketCapRankLabel)
        mainStackView.addArrangedSubview(currencyLogoImage)
        mainStackView.addArrangedSubview(titleStackView)

        addSubview(mainStackView)
        
        marketCapRankLabel.snp.makeConstraints { make in
            make.width.equalTo(Constants.labelWidth)
            make.height.equalTo(Constants.labelbHeight)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        currencyLogoImage.snp.makeConstraints { make in
            make.height.equalTo(Constants.imageHeight)
            make.width.equalTo(Constants.imageWidth)
        }
    }
}
