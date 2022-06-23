//
//  Extension.swift
//  MovieSearchClone
//
//  Created by Rafael Oliveira on 06/06/22.
//

import Foundation
import UIKit

extension UIImageView{
    func loadImagefromUrl(url: String){
        guard let url = URL(string: url) else { return }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UIViewController{
    func setStatusBar(){
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        let frame = CGRect(origin: .zero, size: statusBarSize)
        let statusBarView = UIView(frame: frame)
        
        
        statusBarView.backgroundColor = .systemBlue
        view.addSubview(statusBarView)
    }
    
    func setTabBarImage(imageName: String, title: String){
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}

extension UIView {
    
    func setCellShadow() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 1.0
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.cornerRadius = 15
    }
    
    func setAnchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?,
                   left: NSLayoutXAxisAnchor?,  right: NSLayoutXAxisAnchor?,
                   paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat,
                   width: CGFloat = 0, height: CGFloat = 0){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top{
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left{
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right{
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom{
            self.topAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if width != 0{
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0{
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}


extension UICollectionViewLayout{
    func createLayoutLandscape() -> UICollectionViewCompositionalLayout{
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .fractionalWidth(1/1.8)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .fractionalWidth(1/1.8)),
            subitem: item,
            count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func createLayoutPortrait() -> UICollectionViewCompositionalLayout{
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)
            ),
            subitem: item,
            count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return UICollectionViewCompositionalLayout(section: section)
    }
}
