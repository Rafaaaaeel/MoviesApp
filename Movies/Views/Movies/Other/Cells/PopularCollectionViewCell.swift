//
//  PopularCollectionViewCell.swift
//  MovieSearchClone
//
//  Created by Rafael Oliveira on 22/06/22.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell, ViewFunctions {

    static let identifier = "PopularCollectionViewCell"
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
}

//  MARK: View Functions

extension PopularCollectionViewCell{
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

extension PopularCollectionViewCell{
    func configure(with model: Movie){
        self.imageView.loadImagefromUrl(url: model.posterURL)
    }
}
