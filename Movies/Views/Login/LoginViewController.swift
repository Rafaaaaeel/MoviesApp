//
//  LoginViewController.swift
//  Movies
//
//  Created by Rafael Oliveira on 30/06/22.
//

import UIKit
import FirebaseAuth

internal class LoginViewController: UINavigationController, CodableViews {

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
        label.font = UIFont.boldSystemFont(ofSize: 24)
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
    
    internal lazy var signUp: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Sign up", for: [])
        btn.tintColor = .label
        btn.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        return btn
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
        
        [welcomeLabel,
         emailTextField,
         passwordTextField,
         signInButton
        ].forEach { view in stackView.addArrangedSubview(view) }
        
        view.addSubview(signUp)
        view.addSubview(stackView)
    }
    
    func setupContraints() {
        stackView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.leading.lessThanOrEqualToSuperview().inset(32)
            make.trailing.lessThanOrEqualToSuperview().inset(32)
        }
        
        signUp.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).inset(-8)
            make.trailing.equalTo(stackView)
        }
    }
    
    func additional() {
        self.navigationBar.isHidden = true
        self.view.backgroundColor = .black
    }
    
    
}


internal extension LoginViewController{
   
    
    @objc
    func login(){
        checkIfUserCanLogin()
    }
    
    @objc
    func signUpPressed(_ sender: Any){
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true )
    }
    
    func checkIfUserCanLogin(){
        guard let email = email, !email.isEmpty, let password = password, !password.isEmpty else {return}
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            
            guard let self = self else{
                return
            }
            
            
        })
        
    }
    
    
}
