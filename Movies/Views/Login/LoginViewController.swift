//
//  LoginViewController.swift
//  Movies
//
//  Created by Rafael Oliveira on 30/06/22.
//

import UIKit
import FirebaseAuth

internal class LoginViewController: UIViewController, ViewFunctions {

    internal var email: String? {
        return emailTextField.text
    }
    
    internal var password: String? {
        return passwordTextField.text
    }
    
//  MARK: - UI Components
    
    internal lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    internal lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 20
        stack.axis = .vertical
        return stack
    }()
    
    internal lazy var emailTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "E-mail"
        field.textContentType = .emailAddress
        field.clipsToBounds = true
        field.autocapitalizationType = .none
        field.addBottomBorder()
        return field
    }()
    
    internal lazy var passwordTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Password"
        field.textContentType = .password
        field.clipsToBounds = true
        field.autocapitalizationType = .none
        field.addBottomBorder()
        return field
    }()
    
    internal lazy var signInButton: UIButton = {
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
internal extension LoginViewController{
    
    
    func setupHiearchy() {
        stackView.addArrangedSubview(welcomeLabel)
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


internal extension LoginViewController{
   
    
    @objc
    func login(){
        checkIfUserCanLogin()
    }
    
    func checkIfUserCanLogin(){
        guard let email = email, !email.isEmpty, let password = password, !password.isEmpty else {return}
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            
            guard let strongSelf = self else{
                return
            }
            
            
        })
        
    }
    
    
}
