//
//  RegistrationViewController.swift
//  TokenTrek
//
//  Created by Artyom Mitrofanov on 20.03.2023.
//

import UIKit
import SnapKit

class RegistrationViewController: UIViewController {
    
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
    
    private let formStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
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
        formStackView.addArrangedSubview(emailLabel)
        formStackView.addArrangedSubview(emailTextField)
        formStackView.addArrangedSubview(passwordLabel)
        formStackView.addArrangedSubview(passwordTextField)
        secondaryStackView.addArrangedSubview(alredyRegisterLabel)
        secondaryStackView.addArrangedSubview(signInButton)
        bottomStackView.addArrangedSubview(createAccountButton)
        bottomStackView.addArrangedSubview(secondaryStackView)
        view.addSubview(bottomStackView)
        view.addSubview(formStackView)
    }
    
    private func setConstraints() {
        formStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(110)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        createAccountButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(350)
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(228)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
}
