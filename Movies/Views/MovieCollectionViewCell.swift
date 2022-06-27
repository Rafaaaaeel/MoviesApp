//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Rafael Oliveira on 27/06/22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell{
    
    
    static let identifier = "MovieCollectionViewCell"
    
    lazy var imageResult: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 9.0
        
//        image.contentMode =
        image.layer.masksToBounds = true
        return image
   }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentView.addSubview(imageResult)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageResult.frame = contentView.bounds
    }
}

extension MovieCollectionViewCell{
    func configure(with model: Movie){
        self.imageResult.loadImagefromUrl(url: model.posterURL)
    }
}
