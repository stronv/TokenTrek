//
//  ErrorView.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 05.05.2023.
//

import UIKit

protocol RefreshDelegate: AnyObject {
    func refreshPage()
}

class ErrorView: UIView {
    
    weak var delegate: RefreshDelegate?
    // MARK: - UI
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }()

    private let errorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "errorImage")
        return imageView
    }()

    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Что-то пошло не так..."
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 32)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    let secondaryTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Попробуйте перезагрузить страницу или перезайдите в приложение."
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 14)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let refreshPageButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.blueButton
        button.setTitle("Перезагрузить", for: .normal)
        button.addTarget(self, action: #selector(refreshPageButtonAction), for: .touchUpInside)
        return button
    }()
    
    @objc func refreshPageButtonAction() {
        delegate?.refreshPage()
    }

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
        
    // MARK: - Private metohds
    private func setup() {
        stackView.addArrangedSubview(errorImageView)
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(secondaryTextLabel)
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(209)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
}
