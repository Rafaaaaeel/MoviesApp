//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Rafael Oliveira on 28/06/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell, ViewFunctions {

    static let identifier = "MovieTableViewCell"

    public lazy var menuButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.red, for: [])
        button.setTitle("Button", for: [])
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieTableViewCell{
    func setupHiearchy() {
        
        contentView.addSubview(menuButton)
        
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            menuButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            menuButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

extension MovieTableViewCell{
    func configure(with model: Genre){
        self.menuButton.setTitle(model.name, for: [])
    }
}

