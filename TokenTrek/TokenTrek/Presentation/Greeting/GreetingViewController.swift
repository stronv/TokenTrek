//
//  GreetingViewController.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 19.03.2023.
//

import UIKit
import SnapKit

protocol GreetingViewProtocol: AnyObject {
    func createAccountButtonAction()
    func toCurrencyListButtonAction()
}

class GreetingViewController: UIViewController, GreetingViewProtocol {
    // MARK: - UI
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Добро пожаловать!"
        label.font = UIFont(name: Fonts.ubuntuBold, size: 40)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "TokenTrek - приложение для отслеживания изменений цен на криптовалюты в режиме реального времени."
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 16)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
        
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Создать аккаунт", for: .normal)
        button.layer.cornerRadius = 25
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.blueButton
        button.addTarget(self, action: #selector(createAccountButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.layer.cornerRadius = 25
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.blackButton
        button.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let toMainScreenButton: UIButton = {
        let button = UIButton()
        button.setTitle("На главную", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.gray, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.borderForWhiteButton
        button.addTarget(self, action: #selector(toCurrencyListButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let greetingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }()
    
    private let mainButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    private let secondaryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    
    // MARK: - MVP Properties
    var output: GreetingPresenter?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setConstraints()
    }
    
    // MARK: - Objc Methods
    @objc func createAccountButtonAction() {
        output?.toCreateAccount()
    }
    
    @objc func toCurrencyListButtonAction() {
        output?.toCurrencyList()
    }
    
    @objc func signInButtonAction() {
        output?.toSignIn()
    }
    
    // MARK: - Private Functions
    private func addSubviews() {
        greetingStackView.addArrangedSubview(logoImageView)
        greetingStackView.addArrangedSubview(greetingLabel)
        greetingStackView.addArrangedSubview(descriptionLabel)
        secondaryStackView.addArrangedSubview(createAccountButton)
        secondaryStackView.addArrangedSubview(signInButton)
        mainButtonsStackView.addArrangedSubview(secondaryStackView)
        mainButtonsStackView.addArrangedSubview(toMainScreenButton)
        view.addSubview(mainButtonsStackView)
        view.addSubview(greetingStackView)
    }
    
    private func setConstraints() {
        greetingStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(209)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        mainButtonsStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(45)
        }
        
        secondaryStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        createAccountButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalToSuperview()
            make.trailing.equalTo(signInButton.snp.trailing).inset(110)
        }
        
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.trailing.equalToSuperview()
        }
        
        toMainScreenButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalToSuperview().inset(80)
            make.trailing.equalToSuperview().inset(80)
        }
    }
}
