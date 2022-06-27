//
//  NowPlayinhCollectionViewCell.swift
//  MovieSearchClone
//
//  Created by Rafael Oliveira on 14/06/22.
//

import UIKit


class NowPlayingCollectionViewCell: UICollectionViewCell {
    
    
    
    static let identifier = "NowPlayingCollectionViewCell"
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        return image
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)

        contentView.addSubview(imageView)
        contentView.clipsToBounds = true
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    func configure(with model: Movie){
        self.imageView.loadImagefromUrl(url: model.posterURL)
    }
}
