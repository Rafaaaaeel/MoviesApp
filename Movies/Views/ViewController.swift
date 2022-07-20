//
//  ViewController.swift
//  Movies
//
//  Created by Rafael Oliveira on 28/06/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController, CodableViews {

    private var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "Welcome"
        label.font = UIFont.boldSystemFont(ofSize: 23)
        return label
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 23)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
    
}

extension ViewController{
    func setupHiearchy() {
        
        view.addSubview(welcomeLabel)
        view.addSubview(nameLabel)
    }
    
    func setupContraints() {
        
        welcomeLabel.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom)
            make.leading.equalTo(welcomeLabel.snp.leading)
        }
    }
    
    func additional() {
        view.backgroundColor = .systemBackground
    }
}
