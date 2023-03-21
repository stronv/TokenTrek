//
//  RegistrationViewController.swift
//  TokenTrek
//
//  Created by Artyom Mitrofanov on 20.03.2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    private let emailLabel = UILabel()
    private let passwordLabel = UILabel()
    
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    
    private let createAccountButton = UIButton()
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        super.viewDidLoad()
        set()
        setOnView()
    }
    
    private func set() {
        emailLabel.text = "Адрес электронной почты"
        passwordLabel.text = "Пароль"
        emailTextField.placeholder = "Введите ваш адрес эл.почты"
        passwordTextField.placeholder = "Введите ваш пароль"
        
        createAccountButton.setTitle("Создать аккаунт", for: .normal)
    }
    
    private func setOnView() {
        emailLabel.font = .systemFont(ofSize: 14)
        emailLabel.textAlignment = .left
        
        passwordLabel.font = .systemFont(ofSize: 14)
        passwordLabel.textAlignment = .left
        
        emailTextField.backgroundColor = .white
        emailTextField.layer.cornerRadius = 25
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: emailTextField.frame.height))
        emailTextField.leftViewMode = .always
        emailTextField.layer.borderWidth = 1
        
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 25
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: emailTextField.frame.height))
        passwordTextField.leftViewMode = .always
        passwordTextField.layer.borderWidth = 1
        
        createAccountButton.layer.cornerRadius = 25
        createAccountButton.setTitleColor(.white, for: .normal)
        createAccountButton.backgroundColor = UIColor(cgColor: CGColor(
            red: 29/255,
            green: 26/255,
            blue: 157/255,
            alpha: 1)
        )
        
        
        // MARK: Checking view's
//
//        passwordLabel.layer.borderWidth = 1
//        emailLabel.layer.borderWidth = 1
        
        let formStackView = UIStackView(arrangedSubviews: [
            emailLabel, emailTextField,
            passwordLabel, passwordTextField
        ])
        
        formStackView.axis = .vertical
        formStackView.alignment = .leading
//        formStackView.backgroundColor = .systemMint
        formStackView.spacing = 10
        
        view.addSubview(formStackView)
        
        formStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            formStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            formStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -500),
            formStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: formStackView.topAnchor, constant: 80),
            emailLabel.bottomAnchor.constraint(equalTo: formStackView.bottomAnchor, constant: -155),
            emailLabel.leadingAnchor.constraint(equalTo: formStackView.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: formStackView.trailingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: formStackView.topAnchor, constant: 115),
            emailTextField.bottomAnchor.constraint(equalTo: formStackView.bottomAnchor, constant: -100),
            emailTextField.leadingAnchor.constraint(equalTo: formStackView.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: formStackView.trailingAnchor)
        ])

        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: formStackView.topAnchor, constant: 180),
            passwordLabel.bottomAnchor.constraint(equalTo: formStackView.bottomAnchor, constant: -60),
            passwordLabel.leadingAnchor.constraint(equalTo: formStackView.leadingAnchor, constant: 20),
            passwordLabel.trailingAnchor.constraint(equalTo: formStackView.trailingAnchor),
            
            passwordTextField.leadingAnchor.constraint(equalTo: formStackView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: formStackView.trailingAnchor),
        ])
        
        view.addSubview(createAccountButton)
        
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createAccountButton.topAnchor.constraint(equalTo: formStackView.bottomAnchor, constant: 280),
            createAccountButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
    }
}
