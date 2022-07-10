//
//  RegsiterViewController.swift
//  Movies
//
//  Created by Rafael Oliveira on 30/06/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

internal class RegisterViewController: UINavigationController, ViewFunctions {
    
    
    internal var movies: [Movie] = []
    private let database =  Firestore.firestore()
    
//  MARK: - UI Components
    
    internal lazy var formListView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 20
        stack.axis = .vertical
        return stack
    }()
    
    internal lazy var nameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Name"
        field.clipsToBounds = true
        field.autocapitalizationType = .none
        field.addBottomBorder()
        return field
    }()
    
    internal lazy var emailTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "E-mail"
        field.textContentType = .emailAddress
        field.clipsToBounds = true
        field.autocapitalizationType = .none
        field.addBottomBorder()
        return field
    }()
    
    internal lazy var passwordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.textContentType = .password
        field.clipsToBounds = true
        field.isSecureTextEntry = true
        field.autocapitalizationType = .none
        field.addBottomBorder()
        return field
    }()
    
    internal lazy var confirmPasswordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Confirm Password"
        field.textContentType = .password
        field.clipsToBounds = true
        field.isSecureTextEntry = true
        field.autocapitalizationType = .none
        field.addBottomBorder()
        return field
    }()
    
    internal var passwordRuleLabel: UILabel = {
        let label = UILabel()
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
    
    internal lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: [])
        button.tintColor = .systemGray2
        button.configuration = .filled()
        button.addTarget(self, action: #selector(register), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
//  MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    

}

//  MARK: - View Functions

internal extension RegisterViewController{
    
    
    func setupHiearchy() {
        
        [nameTextField,
         emailTextField,
         passwordTextField,
         confirmPasswordTextField,
         passwordRuleLabel,
         passwordRuleLabel,
         signInButton
        ].forEach { view in formListView.addArrangedSubview(view) }
        
        view.addSubview(formListView)
    }
    
    func setupContraints() {
        formListView.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }
    
    func additional() {
        self.navigationBar.isHidden = true
        self.view.backgroundColor = .black
    }
    
}


//  MARK: - OBJC Functions + Network call

internal extension RegisterViewController{
    
    
    @objc
    func register(){
        shouldRegisterUser()
    }
    
    func shouldRegisterUser(){
        guard let name = nameTextField.text, !name.isEmpty ,let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else { return }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { (result, error) in
            
            guard error == nil else {
                print("Sorry something went wrong")
                return
            }
            
            let db = Firestore.firestore()
            
            db.collection("movies_users").addDocument(data: [
                "id": result!.user.uid,
                "name":name,
                "email":email,
                "movies": self.movies
            ]) { Error in
                if Error != nil{
                    print(Error?.localizedDescription)
                }
            }
            
            print("Created")
            self.present(LoginViewController(), animated: true)
            
        })
    }
    
    
}
