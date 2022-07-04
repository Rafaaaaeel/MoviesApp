//
//  LoginViewController.swift
//  Movies
//
//  Created by Rafael Oliveira on 30/06/22.
//

import UIKit

class LoginViewController: UIViewController, ViewFunctions {

    
//  MARK: - UI Components
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 20
        stack.axis = .vertical
        return stack
    }()
    
    lazy var emailTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "E-mail"
        field.textContentType = .emailAddress
        field.clipsToBounds = true
        field.autocapitalizationType = .none
        field.addBottomBorder()
        return field
    }()
    
    lazy var passwordTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Password"
        field.textContentType = .password
        field.clipsToBounds = true
        field.autocapitalizationType = .none
        field.addBottomBorder()
        return field
    }()
    
    lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign in", for: [])
        button.tintColor = .systemGray2
        button.configuration = .filled()
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()

    
//  MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}


//  MARK: - View Functions
extension LoginViewController{
    func setupHiearchy() {
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(signInButton)
        view.addSubview(stackView)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate(
            [
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
        ])
    }
}


extension LoginViewController{
    @objc func login(){
        checkIfUserCanLogin()
    }
    
    private func checkIfUserCanLogin(){
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {return}
        
        
    }
}
