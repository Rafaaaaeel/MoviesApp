//
//  MoviesViewController.swift
//  MovieSearchClone
//
//  Created by Rafael Oliveira on 03/06/22.
//

import UIKit

class MoviesViewController: UIViewController {

//  MARK: - Mini tests
    
    let NowPlayingEndPoint = "now_playing"
    let PopularEndPoint = "popular"
    let TopRatedEndPoint = "top_rated"
    
    private var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        
        button.setTitle("Call API", for: [])
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    
}

extension MoviesViewController: ViewFunctions{
    func setupHiearchy() {
        view.addSubview(searchButton)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func additional() {
        
    }
}

