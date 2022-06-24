//
//  UpcomingCollectionViewCell.swift
//  MovieSearchClone
//
//  Created by Rafael Oliveira on 22/06/22.
//

import UIKit

class UpcomingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "UpcomingCollectionViewCell"
    
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        return image
    }()
    
    private lazy var movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Movie title Test"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
    
        contentView.addSubview(imageView)
        addSubview(movieNameLabel)
        
        contentView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 0),
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    func configure(with model: Movie){
        self.movieNameLabel.text = model.title
        self.imageView.loadImagefromUrl(url: model.backdropURL)
    }
}
