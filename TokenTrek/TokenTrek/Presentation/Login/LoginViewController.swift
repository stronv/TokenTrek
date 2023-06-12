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
        label.text = "email_label".localized
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 14)
        label.textAlignment = .left
        label.textColor = UIColor(named: "mainTextFontColor")
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "password_label".localized
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 14)
        label.textAlignment = .left
        label.textColor = UIColor(named: "mainTextFontColor")
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "email_text_field_placeholder".localized
        textField.backgroundColor = UIColor(named: "placeholderColor")
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
        textField.backgroundColor = UIColor(named: "placeholderColor")
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
        button.setTitle("sign_in_button".localized, for: .normal)
        button.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let stillNoAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "still_no_account_label".localized 
        label.font = UIFont(name: Fonts.ubuntuRegular, size: 18)
        label.textColor = UIColor(named: "secondaryTextFontColor")
        label.textAlignment = .center
        return label
    }()
    
    private let registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("create_account_button".localized, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(UIColor(named: "mainTextFontColor"), for: .normal)
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
        button.setTitle("sign_out_button".localized, for: .normal)
        button.addTarget(self, action: #selector(signOutButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let toMainScreenButton = {
        let button = UIButton()
        button.setTitle("to_main_screen_button".localized, for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor(named: "transparentButtonColor"), for: .normal)
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
        view.backgroundColor = UIColor(named: "backgroundColor")
        
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
    
    private struct Constants {
        static let LabelLeading: CGFloat = 38
        static let Labeltrailing: CGFloat = 38
        
        static let emailLabelTop: CGFloat = 100
        static let passwordLabelTop: CGFloat = 30
        
        static let passwordTextFieldTop: CGFloat = 10
        static let emailTextFieldTop: CGFloat = 25
        
        static let textFieldLeading: CGFloat = 20
        static let textFieldTrailing: CGFloat = 20
        static let textFieldHeight: CGFloat = 48
        
        static let stackViewLeading: CGFloat = 20
        static let stackViewTrailing: CGFloat = 20
        static let stackViewBottom: CGFloat = 228
        
        static let buttonLeading: CGFloat = 20
        static let buttonTrailing: CGFloat = 20
        static let buttonHeight: CGFloat = 50
        static let buttonTop: CGFloat = 20
    }
    
    private func setConstraints() {
        emailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.emailLabelTop)
            make.leading.equalToSuperview().inset(Constants.LabelLeading)
            make.trailing.equalToSuperview().inset(Constants.Labeltrailing)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.top).offset(Constants.emailTextFieldTop)
            make.leading.equalToSuperview().inset(Constants.textFieldLeading)
            make.trailing.equalToSuperview().inset(Constants.textFieldTrailing)
            make.height.equalTo(Constants.textFieldHeight)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(Constants.passwordLabelTop)
            make.leading.equalToSuperview().inset(Constants.LabelLeading)
            make.trailing.equalToSuperview().inset(Constants.Labeltrailing)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(Constants.passwordTextFieldTop)
            make.leading.equalToSuperview().inset(Constants.textFieldLeading)
            make.trailing.equalToSuperview().inset(Constants.textFieldTrailing)
            make.height.equalTo(Constants.textFieldHeight)
        }
        
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(Constants.stackViewBottom)
            make.leading.equalToSuperview().inset(Constants.stackViewLeading)
            make.trailing.equalToSuperview().inset(Constants.stackViewTrailing)
        }
        
        toMainScreenButton.snp.makeConstraints { make in
            make.top.equalTo(bottomStackView.snp.bottom).offset(Constants.buttonTop)
            make.leading.equalToSuperview().inset(Constants.buttonLeading)
            make.trailing.equalToSuperview().inset(Constants.buttonTrailing)
            make.height.equalTo(Constants.buttonHeight)
        }
        
        signOutButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
            make.leading.equalToSuperview().inset(Constants.buttonLeading)
            make.trailing.equalToSuperview().inset(Constants.buttonTrailing)
            make.top.equalTo(toMainScreenButton.snp.bottom).offset(Constants.buttonTop)
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
            print("Succes")
        case .failure:
            print("error")
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
