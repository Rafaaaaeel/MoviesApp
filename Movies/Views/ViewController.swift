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
    
    private let movieID: Int
    
    init(movieID: Int){
        self.movieID = movieID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var movieService = MovieStore.shared
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    fileprivate lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
//        image.layer.cornerRadius = 9.0
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
            
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 2),
            titleLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
            
        ])
    }
    
    func additional() {
        Task{
            await loadMovie()
            guard let title = self.movie?.title else {return}
            guard let url = self.movie?.backdropURL else {return}
            self.imageView.loadImagefromUrl(url: url)
            self.titleLabel.text = title

        }
        
        view.backgroundColor = .systemBackground
    }
    
    func loadMovie() async{
        do{
            let movie = try await self.movieService.fetchMovie(id: movieID)
            self.movie = movie
        } catch{
            
        }
    }
}

