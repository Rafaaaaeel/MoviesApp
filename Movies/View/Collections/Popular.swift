//
//  PopularCell.swift
//  MovieSearchClone
//
//  Created by Rafael Oliveira on 22/06/22.
//

import UIKit

class PopularCell: UICollectionViewCell, ViewFunctions, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    static let identifier = "PopularCell"
    
    var movies: [Movie]?
    
    private let movieService: MovieService = MovieStore.shared

    private lazy var nowPlayingTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Popular"
        label.font = UIFont.boldSystemFont(ofSize: 23)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout.createLayoutPortrait())
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.isScrollEnabled = false
  
        cv.showsHorizontalScrollIndicator = false
        cv.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: PopularCollectionViewCell.identifier)
        return cv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
}

extension PopularCell{
    func setupHiearchy() {
        addSubview(collectionView)
        addSubview(nowPlayingTitleLabel)
    }
    
    func setupContraints() {
        collectionView.frame = bounds
        
        NSLayoutConstraint.activate([
            nowPlayingTitleLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
            nowPlayingTitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: collectionView.leadingAnchor, multiplier: 1)
        ])
    }
    
    func additional() {
        Task{
            await loadMovie()
        }
    }
    
    func loadMovie() async{
        do{
            let movies = try await self.movieService.fetchMovies(from: .popular)
            self.movies = movies
            collectionView.reloadData()
        } catch{
            
        }
    }
}

extension PopularCell{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath) as! PopularCollectionViewCell
        guard let movies = self.movies else { return cell}
        
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
}
