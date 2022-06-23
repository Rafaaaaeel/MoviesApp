//
//  ViewController.swift
//  MovieSearchClone
//
//  Created by Rafael Oliveira on 04/06/22.
//

import Foundation
import UIKit


class ViewController: UIViewController{
    
    var movie: Movie?
    
    private var movieService = MovieStore.shared
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 9.0
        image.layer.masksToBounds = true
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension ViewController: ViewFunctions{
    func setupHiearchy() {
        view.addSubview(titleLabel)
        view.addSubview(imageView)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            
            
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 2),
            titleLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
            
        ])
    }
    
    func additional() {
        Task{
            await loadMovie()
            guard let title = self.movie?.title else {return}
            guard let url = self.movie?.posterURL else {return}
            self.imageView.loadImagefromUrl(url: url)
            self.titleLabel.text = title

        }
    }
    
    func loadMovie() async{
        do{
            let movie = try await self.movieService.fetchMovie(id: 453395)
            self.movie = movie
        } catch{
            
        }
    }
}

