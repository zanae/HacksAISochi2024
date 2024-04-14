//
//  ConfirmController.swift
//  PriceControl
//
//  Created by Матвей Кузнецов on 13.04.2024.
//

import UIKit

class ConfirmController: UIViewController {
    
    private lazy var codeTextField = {
        let textField = UITextField()
        textField.placeholder = "Подтверждение"
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var authButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(authButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Подтвердить", for: .normal)
        return button
    }()
    
    var onSuccessfulLogin: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupLayout()
        
        title = "Введите код"
        
    }
    
    private func setupLayout() {
        view.addSubview(codeTextField)
        view.addSubview(authButton)
        
        NSLayoutConstraint.activate([
            codeTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            codeTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            codeTextField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -32),
            
            authButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            authButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            authButton.topAnchor.constraint(greaterThanOrEqualTo: codeTextField.bottomAnchor, constant: 48),
            authButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48)
        ])
    
    }
    
    @objc func authButtonPressed() {
        onSuccessfulLogin?()
    }
}
