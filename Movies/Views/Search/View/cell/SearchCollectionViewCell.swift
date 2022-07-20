//
//  SearchTableViewCell.swift
//  Movies
//
//  Created by Rafael Oliveira on 24/06/22.
//

import UIKit
import SkeletonView

class SearchMoviesCollectionViewCell: UICollectionViewCell{
    
    
    static let identifier = "ImagesTestViewCell"
    
    lazy var imageResult: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 9.0
        image.layer.masksToBounds = true
        return image
   }()
    
//  MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageResult)
        contentView.clipsToBounds = true
        self.isSkeletonable = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageResult.frame = contentView.bounds
    }
}

//  MARK: - View Model

extension SearchMoviesCollectionViewCell{
    func configure(with model: Movie){
        DispatchQueue.main.async {
            self.imageResult.sd_setImage(with: model.posterURL)
        }
    }
}
