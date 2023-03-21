//
//  GreetingViewController.swift
//  TokenTrek
//
//  Created by Artyom Mitrofanov on 19.03.2023.
//

import UIKit

class GreetingViewController: UIViewController {
    
    private let greetingLabel = UILabel()
    private let descriptionLabel = UILabel()
        
    private let createAccountButton = UIButton()
    private let signInButton = UIButton()
    private let toMainScreenButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        set()
        setupOnView()
    }
    
    private func set() {
        greetingLabel.text = "Добро пожаловать!"
        descriptionLabel.text = "TokenTrek - приложение для отслеживания изменений цен на криптовалюты в режиме реального времени."
        
        createAccountButton.setTitle("Создать аккаунт", for: .normal)
        signInButton.setTitle("Войти", for: .normal)
        toMainScreenButton.setTitle("На главную", for: .normal)
    }
    
    private func setupOnView() {
        greetingLabel.font = .boldSystemFont(ofSize: 40)
        greetingLabel.numberOfLines = 0
        greetingLabel.textAlignment = .center
        
//        descriptionLabel.font = UIFont(name: "Ubuntu", size: 14)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        
        createAccountButton.layer.cornerRadius = 25
        createAccountButton.setTitleColor(.white, for: .normal)
        createAccountButton.backgroundColor = UIColor(cgColor: CGColor(
            red: 29/255,
            green: 26/255,
            blue: 157/255,
            alpha: 1)
        )
        
        signInButton.layer.cornerRadius = 25
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.backgroundColor = UIColor(cgColor: CGColor(
            red: 9/255,
            green: 14/255,
            blue: 20/255,
            alpha: 1)
        )
        
        toMainScreenButton.layer.cornerRadius = 25
        toMainScreenButton
            .setTitleColor(UIColor(cgColor:
                                    CGColor(
                                        red: 37/255,
                                        green: 41/255,
                                        blue: 45/255,
                                        alpha: 1)
                                  ),
                           for: .normal)
        toMainScreenButton.backgroundColor = .clear
        toMainScreenButton.layer.borderWidth = 1
        toMainScreenButton.layer.borderColor = CGColor(red: 37/255, green: 41/255, blue: 45/255, alpha: 1)
                        
        let greetingStackView = UIStackView(arrangedSubviews: [
            greetingLabel, descriptionLabel
        ])
        
        let buttonsStackView = UIStackView(arrangedSubviews: [
            createAccountButton, signInButton, toMainScreenButton
        ])
        
        greetingStackView.axis = .vertical
        greetingStackView.alignment = .center
        
        buttonsStackView.axis = .horizontal
        buttonsStackView.alignment = .leading
        buttonsStackView.spacing = 10
                
        view.addSubview(greetingStackView)
        view.addSubview(buttonsStackView)
        
        greetingStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        toMainScreenButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            greetingStackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            greetingStackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -200
            ), // убрать
            greetingStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            greetingStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -20
            ),
            
            buttonsStackView.topAnchor.constraint(
                equalTo: greetingStackView.bottomAnchor
            ), // тут поправить
            buttonsStackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
            buttonsStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            buttonsStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -20
            ),
        ])
        
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(
                equalTo: greetingStackView.topAnchor
            ),
            greetingLabel.bottomAnchor.constraint(
                equalTo: greetingStackView.bottomAnchor
            ),
            greetingLabel.leadingAnchor.constraint(
                equalTo: greetingStackView.leadingAnchor
            ),
            greetingLabel.trailingAnchor.constraint(
                equalTo: greetingStackView.trailingAnchor
            ), // убрать потом
            
            descriptionLabel.topAnchor.constraint(
                equalTo: greetingStackView.topAnchor,
                constant: 180 // spacing отвечает за это
            ),
            descriptionLabel.bottomAnchor.constraint(
                equalTo: greetingStackView.bottomAnchor
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: greetingStackView.leadingAnchor
            ),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: greetingStackView.trailingAnchor
            )
        ])
        
        NSLayoutConstraint.activate([
            createAccountButton.leadingAnchor.constraint(equalTo: buttonsStackView.leadingAnchor),
            createAccountButton.trailingAnchor.constraint(equalTo: buttonsStackView.trailingAnchor, constant: -120),
            createAccountButton.topAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: 40),
            createAccountButton.bottomAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: -110),
            
            signInButton.leadingAnchor.constraint(equalTo: createAccountButton.trailingAnchor, constant: 5),
            signInButton.trailingAnchor.constraint(equalTo: buttonsStackView.trailingAnchor),
            signInButton.topAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: 40),
            signInButton.bottomAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: -110),
            
            toMainScreenButton.leadingAnchor.constraint(equalTo: buttonsStackView.leadingAnchor),
            toMainScreenButton.trailingAnchor.constraint(equalTo: buttonsStackView.trailingAnchor),
            toMainScreenButton.topAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: 100),
            toMainScreenButton.bottomAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: -50)
        ])
    }
}
