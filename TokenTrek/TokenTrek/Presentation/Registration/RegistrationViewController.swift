//
//  RegistrationViewController.swift
//  TokenTrek
//
//  Created by Artyom Mitrofanov on 20.03.2023.
//

import UIKit
import SnapKit

protocol RegistrationViewProtocol: AnyObject {
    
}

class RegistrationViewController: UIViewController, RegistrationViewProtocol {
    
    //MARK: - UI
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Адрес электронной почты"
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 14)
        label.textAlignment = .left
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 14)
        label.textAlignment = .left
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите ваш адрес эл.почты"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 25
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.borderWidth = 1
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите ваш пароль"
        textField.isSecureTextEntry = true
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 25
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.borderWidth = 1
        return textField
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.blueButton
        button.setTitle("Создать аккаунт", for: .normal)
        return button
    }()
    
    private let alredyRegisterLabel: UILabel = {
        let label = UILabel()
        label.text = "Уже есть аккаунт?"
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 18)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
        
    private let bottomStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.spacing = 30
        return stackview
    }()
    
    private let secondaryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setConstraints()
    }
    
    //MARK: - Private Functions
    private func addSubviews() {
        secondaryStackView.addArrangedSubview(alredyRegisterLabel)
        secondaryStackView.addArrangedSubview(signInButton)
        bottomStackView.addArrangedSubview(createAccountButton)
        bottomStackView.addArrangedSubview(secondaryStackView)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(bottomStackView)
    }
    
    private func setConstraints() {
        emailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.equalToSuperview().inset(38)
            make.trailing.equalToSuperview().inset(38)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.top).offset(25)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.leading.equalToSuperview().inset(38)
            make.trailing.equalToSuperview().inset(38)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        createAccountButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(228)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
}
