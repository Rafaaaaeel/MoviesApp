//
//  NowPlayinhCollectionViewCell.swift
//  MovieSearchClone
//
//  Created by Rafael Oliveira on 14/06/22.
//

import UIKit
import SkeletonView

class NowPlayingCollectionViewCell: UICollectionViewCell, ViewFunctions {

    static let identifier = "NowPlayingCollectionViewCell"

//  MARK: - UI Components
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        return image
    }()
    
//  MARK: - Init
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setup()
        self.isSkeletonable = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
}

//  MARK: - View Functions

extension NowPlayingCollectionViewCell{
    func setupHiearchy() {
        contentView.addSubview(imageView)
    }
    
    func setupContraints() {
        //
    }
    
    func additional() {
        contentView.clipsToBounds = true
    }
}

//  MARK: - View Model

extension NowPlayingCollectionViewCell{
    func configure(with model: Movie){
        self.imageView.loadImagefromUrl(url: model.posterURL)
    }
}
