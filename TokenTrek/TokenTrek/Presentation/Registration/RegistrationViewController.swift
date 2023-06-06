//
//  RegistrationViewController.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 20.03.2023.
//

import UIKit
import SnapKit

protocol RegistrationViewProtocol: AnyObject {
    func updateSignUpState(_ state: SignUpState)
}

class RegistrationViewController: UIViewController, RegistrationViewProtocol {
    
    // MARK: - UI
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "email_label".localized
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 14)
        label.textAlignment = .left
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "password_label".localized
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 14)
        label.textAlignment = .left
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "email_text_field_placeholder".localized
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 25
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clipsToBounds = false
        textField.layer.shadowOpacity = 0.1
        textField.layer.shadowOffset = CGSize(width: 0, height: 0)
        textField.layer.cornerRadius = 22
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "password_text_field_placeholder".localized
        textField.isSecureTextEntry = true
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 25
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clipsToBounds = false
        textField.layer.shadowOpacity = 0.1
        textField.layer.shadowOffset = CGSize(width: 0, height: 0)
        textField.layer.cornerRadius = 22
        return textField
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.blueButton
        button.setTitle("create_account_button".localized, for: .normal)
        button.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
        return button
    }()
    
    private let alredyRegisterLabel: UILabel = {
        let label = UILabel()
        label.text = "alredy_register_label".localized
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 18)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("sign_in_button".localized, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
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
    
    private let toMainScreenButton = {
        let button = UIButton()
        button.setTitle("to_main_screen_button".localized, for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.gray, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.borderForWhiteButton
        button.addTarget(self, action: #selector(toMainScreenButtonAction), for: .touchUpInside)
        return button
    }()
    
    var output: RegistrationPresenter!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        setConstraints()
    }
    
    // MARK: - Private Functions
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
        view.addSubview(toMainScreenButton)
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
        
        toMainScreenButton.snp.makeConstraints { make in
            make.top.equalTo(bottomStackView.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    private func showAlert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(defaultAction)
        self.present(alert, animated: true)
    }
}

extension RegistrationViewController {
    // MARK: - Objc Methods
    @objc func registerPressed() {
        output.signUp(email: emailTextField.text!, password: passwordTextField.text) { result in
            switch result {
            case .succes:
                print("Succes from Presenter")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc func backButtonAction() {
        output.showGreetingPage()
    }
    
    @objc func signInButtonPressed() {
        output.toSignIn()
    }
    
    @objc func toMainScreenButtonAction() {
        output.showCurrencyList()
    }
}

extension RegistrationViewController {
    // MARK: - Public Methods
    func updateSignUpState(_ state: SignUpState) {
        switch state {
        case .succes:
            print("succes")
        case .failure:
            showAlert(
                alertTitle: "Ошибка!",
                alertMessage: "\(AuthError.unknownError)")
        }
    }
}
