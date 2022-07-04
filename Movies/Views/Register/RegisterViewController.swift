//
//  RegsiterViewController.swift
//  Movies
//
//  Created by Rafael Oliveira on 30/06/22.
//

import UIKit

class RegisterViewController: UIViewController, ViewFunctions {
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 20
        stack.axis = .vertical
        return stack
    }()
    
    lazy var nameTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Name"
        field.clipsToBounds = true
        field.autocapitalizationType = .none
        field.addBottomBorder()
        return field
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
    
    lazy var confirmPasswordTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Confirm Password"
        field.textContentType = .password
        field.clipsToBounds = true
        field.autocapitalizationType = .none
        field.addBottomBorder()
        return field
    }()
    
    var passwordRuleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.numberOfLines = 0
        label.text = """
        * Use at least 8 characters
        * Use upper and lower case characters
        * Use 1 or more numbers
        * Use special characters
        """

        return label
    }()
    
    lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign up", for: [])
        button.tintColor = .systemGray2
        button.configuration = .filled()
        button.addTarget(self, action: #selector(register), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

}

extension RegisterViewController{
    func setupHiearchy() {
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(passwordRuleLabel)
        stackView.addArrangedSubview(signInButton)
        view.addSubview(stackView)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
        ])
    }
}


extension RegisterViewController{
    @objc func register(){
        shouldRegisterUser()
    }
    
    private func shouldRegisterUser(){
        
    }
}
