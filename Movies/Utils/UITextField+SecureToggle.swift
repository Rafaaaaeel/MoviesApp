//
//  UITextField+SecureToggle.swift
//  Movies
//
//  Created by Rafael Oliveira on 10/07/22.
//

import Foundation
import UIKit



extension UITextField{
    
    func enablePasswordToggle(){
        passwordTottleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordTottleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        passwordTottleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = passwordTottleButton
        rightViewMode = .always
    }
    
    @objc
    func togglePasswordView(_ sender: Any){
        isSecureTextEntry.toggle()
        passwordTottleButton.isSelected.toggle()
    }
}
