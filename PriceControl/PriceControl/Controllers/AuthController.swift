//
//  AuthController.swift
//  PriceControl
//
//  Created by Матвей Кузнецов on 12.04.2024.
//

import UIKit

class AuthController: UIViewController {
    private enum Workflow {
        case signIn
        case signUp
    }
    
    private lazy var authControl = {
        let control = UISegmentedControl(items: ["Вход", "Регистрация"])
        control.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        return control
    }()
    
    private lazy var emailTextField = {
        let textField = UITextField()
        textField.placeholder = "Электронная почта"
        textField.keyboardType = .emailAddress
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var phoneNumberTextField = {
        let textField = UITextField()
        textField.placeholder = "Номер телефона"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .phonePad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var textFieldStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var authButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(authButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var onSuccessfulLogin: (() -> Void)?
    
    private var currentWorkflow: Workflow = .signIn

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Контролируем цены вместе"
        view.backgroundColor = .systemBackground
        setupLayout()
        updateWorkflow(currentWorkflow)
    }

    private func setupLayout() {
        view.addSubview(authControl)
        view.addSubview(textFieldStackView)
        view.addSubview(authButton)
        
        authControl.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        authButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        textFieldStackView.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
        
        NSLayoutConstraint.activate([
            authControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            authControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            authControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            
            textFieldStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            textFieldStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            textFieldStackView.topAnchor.constraint(greaterThanOrEqualTo: authControl.bottomAnchor, constant: 48),
            textFieldStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            
            authButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            authButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            authButton.topAnchor.constraint(greaterThanOrEqualTo: textFieldStackView.bottomAnchor, constant: 48),
            authButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48)
        ])
        
        
    }
    
    private func updateWorkflow(_ workflow: Workflow) {
        currentWorkflow = workflow
        
        emailTextField.removeFromSuperview()
        phoneNumberTextField.removeFromSuperview()
        textFieldStackView.removeArrangedSubview(emailTextField)
        textFieldStackView.removeArrangedSubview(phoneNumberTextField)
        
        switch currentWorkflow {
        case .signIn:
            authButton.setTitle("Вход", for: .normal)
            textFieldStackView.addArrangedSubview(emailTextField)
        case .signUp:
            authButton.setTitle("Регистрация", for: .normal)
            textFieldStackView.addArrangedSubview(emailTextField)
            textFieldStackView.addArrangedSubview(phoneNumberTextField)
        }
        
        view.layoutIfNeeded()
    }

    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            updateWorkflow(.signIn)
        } else {
            updateWorkflow(.signUp)
        }
    }
    
    @objc func authButtonPressed() {
        let confirmController = ConfirmController()
        confirmController.onSuccessfulLogin = onSuccessfulLogin
        navigationController?.pushViewController(confirmController, animated: true)
    }
    
}
