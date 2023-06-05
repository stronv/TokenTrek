//
//  LoginViewController.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 20.03.2023.
//

import UIKit
import SnapKit

protocol LoginViewProtocol: AnyObject {
    func updateSignUpState(_ state: SignUpState)
    func checkAuthState(state: AuthStatus)
}

class LoginViewController: UIViewController, LoginViewProtocol {
    
    // MARK: - UI
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
        textField.clipsToBounds = false
        textField.layer.shadowOpacity = 0.1
        textField.layer.shadowOffset = CGSize(width: 0, height: 0)
        textField.layer.cornerRadius = 22
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
        textField.clipsToBounds = false
        textField.layer.shadowOpacity = 0.1
        textField.layer.shadowOffset = CGSize(width: 0, height: 0)
        textField.layer.cornerRadius = 22
        return textField
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.blueButton
        button.setTitle("Войти", for: .normal)
        button.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let stillNoAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Нет аккаунта?"
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 18)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()
    
    private let registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(registrationButtonAction), for: .touchUpInside)
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
    
    private let signOutButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.blueButton
        button.setTitle("Выйти", for: .normal)
        button.addTarget(self, action: #selector(signOutButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let toMainScreenButton = {
        let button = UIButton()
        button.setTitle("На главную", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.gray, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.borderForWhiteButton
        button.addTarget(self, action: #selector(toMainScreenButtonAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - MVP Properties
    var output: LoginPresenter!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        output.viewDidLoadEvent()
        addSubviews()
        setConstraints()
    }
    
    // MARK: - Private Functions
    private func addSubviews() {
        secondaryStackView.addArrangedSubview(stillNoAccountLabel)
        secondaryStackView.addArrangedSubview(registrationButton)
        bottomStackView.addArrangedSubview(signInButton)
        bottomStackView.addArrangedSubview(secondaryStackView)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(bottomStackView)
        view.addSubview(signOutButton)
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
        
        signInButton.snp.makeConstraints { make in
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
        
        signOutButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(toMainScreenButton.snp.bottom).offset(10)
        }
    }
    
    private func showAlert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(defaultAction)
        self.present(alert, animated: true)
    }
}

extension LoginViewController {
    // MARK: - Objc Methods
    @objc func signInButtonAction() {
        output.signIn(email: emailTextField.text!, password: passwordTextField.text!) { result in
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
        output.signIn(
            email: emailTextField.text!,
            password: passwordTextField.text!) { result in
                switch result {
                case .succes:
                    print("succes login")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    @objc func registrationButtonAction() {
        output.showRegistration()
    }
    
    @objc func signOutButtonAction() {
        output.showMainPage()
    }
    
    @objc func toMainScreenButtonAction() {
        output.showCurrencyList()
    }
}

extension LoginViewController {
    // MARK: - Public Methods
    func updateSignUpState(_ state: SignUpState) {
        switch state {
        case .succes:
            showAlert(
                alertTitle: "Вы успешно зарегистрированы!",
                alertMessage: "")
        case .failure:
            showAlert(
                alertTitle: "Ошибка!",
                alertMessage: "\(AuthError.unknownError)")
        }
    }
    
    func checkAuthState(state: AuthStatus) {
        switch state {
        case .isAuthorized:
            bottomStackView.isHidden = true
            secondaryStackView.isHidden = true
            emailLabel.isHidden = true
            emailTextField.isHidden = true
            passwordLabel.isHidden = true
            passwordTextField.isHidden = true
            signOutButton.isHidden = false
        case .isNonauthorized:
            bottomStackView.isHidden = false
            secondaryStackView.isHidden = false
            signOutButton.isHidden = true
        }
    }
}
