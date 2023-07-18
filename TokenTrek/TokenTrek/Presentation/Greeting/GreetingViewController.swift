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
        imageView.tintColor = UIColor(named: "mainTextFontColor")
        return imageView
    }()
    
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "greeting_label".localized
        label.font = UIFont(name: Fonts.ubuntuBold, size: 40)
        label.textColor = UIColor(named: "mainTextFontColor")
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "description_label".localized
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 16)
        label.textColor = UIColor(named: "secondaryTextFontColor")
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
        
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("create_account_button".localized, for: .normal)
        button.layer.cornerRadius = 25
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.blueButton
        button.addTarget(self, action: #selector(createAccountButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("sign_in_button".localized, for: .normal)
        button.layer.cornerRadius = 25
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.blackButton
        button.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let toMainScreenButton: UIButton = {
        let button = UIButton()
        button.setTitle("to_main_screen_button".localized, for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor(named: "transparentButtonColor"), for: .normal)
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
    var output: GreetingViewOutput?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")
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
    
    private struct Constants {
        static let leading: CGFloat = 20
        static let trailing: CGFloat = 20
        
        static let buttonHeight: CGFloat = 50
        
        static let mainScreenButtonLeading: CGFloat = 80
        static let mainScreenButtonTrailing: CGFloat = 80
        
        static let createAccountButtonTrailing: CGFloat = 110
        
        static let mainButtomsStackViewBottom: CGFloat = 45
        
        static let greetingStackViewTop: CGFloat = 209
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
            make.top.equalToSuperview().inset(Constants.greetingStackViewTop)
            make.leading.equalToSuperview().inset(Constants.leading)
            make.trailing.equalToSuperview().inset(Constants.trailing)
        }
        
        mainButtonsStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Constants.leading)
            make.trailing.equalToSuperview().inset(Constants.trailing)
            make.bottom.equalToSuperview().inset(Constants.mainButtomsStackViewBottom)
        }
        
        secondaryStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        createAccountButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
            make.leading.equalToSuperview()
            make.trailing.equalTo(signInButton.snp.trailing).inset(Constants.createAccountButtonTrailing)
        }
        
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
            make.trailing.equalToSuperview()
        }
        
        toMainScreenButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
            make.leading.equalToSuperview().inset(Constants.mainScreenButtonLeading)
            make.trailing.equalToSuperview().inset(Constants.mainScreenButtonTrailing)
        }
    }
}
