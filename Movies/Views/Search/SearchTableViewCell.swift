//
//  SearchTableViewCell.swift
//  Movies
//
//  Created by Rafael Oliveira on 24/06/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell, ViewFunctions {

    static let indentifier = "SearchTableViewCell"
    static let rowHeight: CGFloat = 340
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Movie"
        label.font = UIFont.boldSystemFont(ofSize: 23)
        return label
    }()
    
     lazy var imageResult: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 9.0
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var describeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Movie"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchTableViewCell{
    func setupHiearchy() {
        addSubview(imageResult)
        addSubview(describeLabel)
        addSubview(movieTitleLabel)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            imageResult.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            imageResult.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            movieTitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: imageResult.trailingAnchor, multiplier: 2),
            movieTitleLabel.topAnchor.constraint(equalTo: imageResult.topAnchor),
            
            movieTitleLabel.widthAnchor.constraint(equalToConstant: 170),
            
            describeLabel.topAnchor.constraint(equalToSystemSpacingBelow: movieTitleLabel.bottomAnchor, multiplier: 0),
            describeLabel.leadingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor),
            describeLabel.widthAnchor.constraint(equalToConstant: 130),
            describeLabel.heightAnchor.constraint(equalToConstant: 260),
            
            imageResult.heightAnchor.constraint(equalToConstant: 280),
            imageResult.widthAnchor.constraint(equalToConstant: 180),
        ])
    }
    
    func configure(with model: Movie){
        self.movieTitleLabel.text = model.title
        self.describeLabel.text = model.overview
        self.imageResult.loadImagefromUrl(url: model.posterURL)
    }
}
