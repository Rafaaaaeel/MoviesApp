//
//  MainCollectionViewCell.swift
//  MovieSearchClone
//
//  Created by Rafael Oliveira on 13/06/22.
//

import UIKit

class UpcomingCell: UICollectionViewCell, ViewFunctions, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    static let identifier = "UpcomingCell"
    
    var movies: [Movie]?
    
    private let movieService: MovieService = MovieStore.shared
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout.createLayoutLandscape())
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.isScrollEnabled = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(UpcomingCollectionViewCell.self, forCellWithReuseIdentifier: UpcomingCollectionViewCell.identifier)
        return cv
    }()
    
    private lazy var upcoomingTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Upcoming"
        label.font = UIFont.boldSystemFont(ofSize: 23)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
}

extension UpcomingCell{
    func setupHiearchy() {
        addSubview(collectionView)
        addSubview(upcoomingTitleLabel)
    }
    
    func setupContraints() {
        collectionView.frame = bounds
        
        NSLayoutConstraint.activate([
            upcoomingTitleLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -12),
            upcoomingTitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: collectionView.leadingAnchor, multiplier: 1)
        ])
    }

    func additional() {
        Task{
            await loadMovie()
        }
    }
    
    func loadMovie() async{
        do{
            let movies = try await self.movieService.fetchMovies(from: .upcoming)
            self.movies = movies
            collectionView.reloadData()
        } catch{
            
        }
    }
}

extension UpcomingCell{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCollectionViewCell.identifier, for: indexPath) as! UpcomingCollectionViewCell
        
        guard let movies = self.movies else { return cell}
        
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: frame.height - 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 14, bottom: 0, right: 14)
    }
    
}
