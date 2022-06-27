//
//  ViewController.swift
//  MovieSearchClone
//
//  Created by Rafael Oliveira on 04/06/22.
//

import Foundation
import UIKit


class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var movie: Movie?
    var similarMovies: [Movie]?
    
    private let movieID: Int
    private var movieService = MovieStore.shared
    
    
    
    
//  MARK: - Init
    init(movieID: Int){
        self.movieID = movieID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - UI Components
    
    lazy var posterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Movie"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        return label
    }()
    
    lazy var voteStarImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .systemYellow
        return image
    }()
    
    lazy var voteAvaregeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    lazy var voteAvaregeTotalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "/10"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var similarMoviesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Similar Titles"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .systemBackground
        cv.delegate = self
        cv.dataSource = self
        cv.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
//  MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = false;
    }
    
}

//  MARK: - View Functions
extension ViewController: ViewFunctions{
    func setupHiearchy() {
        
        view.addSubview(collectionView)
        view.addSubview(posterImage)
        view.addSubview(overviewLabel)
        view.addSubview(voteStarImage)
        view.addSubview(voteAvaregeLabel)
        view.addSubview(voteAvaregeTotalLabel)
        view.addSubview(similarMoviesLabel)
        
    }
    
    func setupContraints() {
        
        
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            posterImage.heightAnchor.constraint(equalToConstant: 230),
        ])

        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalToSystemSpacingBelow: posterImage.bottomAnchor, multiplier: 2),
            overviewLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: posterImage.leadingAnchor, multiplier: 2),
            overviewLabel.trailingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            voteStarImage.topAnchor.constraint(equalToSystemSpacingBelow: overviewLabel.bottomAnchor, multiplier: 2),
            voteStarImage.leadingAnchor.constraint(equalTo: overviewLabel.leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            voteAvaregeLabel.leadingAnchor.constraint(equalTo: voteStarImage.trailingAnchor, constant: 12),
            voteAvaregeLabel.centerYAnchor.constraint(equalTo: voteStarImage.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            voteAvaregeTotalLabel.leadingAnchor.constraint(equalTo: voteAvaregeLabel.trailingAnchor, constant: 1),
            voteAvaregeTotalLabel.centerYAnchor.constraint(equalTo: voteAvaregeLabel.centerYAnchor),
        ])
        
        
        NSLayoutConstraint.activate([
            similarMoviesLabel.topAnchor.constraint(equalToSystemSpacingBelow: voteAvaregeTotalLabel.bottomAnchor, multiplier: 2),
            similarMoviesLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: posterImage.leadingAnchor, multiplier: 2),
        ])
        
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalToSystemSpacingBelow: similarMoviesLabel.bottomAnchor, multiplier: 2),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func additional() {
        Task{
            await loadMovie()
           
            // Configure
            guard let movie = self.movie else {return}

            self.posterImage.loadImagefromUrl(url: movie.backdropURL)
            self.overviewLabel.text = movie.overview
            self.voteAvaregeLabel.text = String(floor(movie.voteAverage * 10)/10.0)
            self.navigationItem.title = movie.title
        }
        
        Task{
            await loadSimilarMovies()
        }
        view.backgroundColor = .systemBackground
    }
}

extension ViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let movies = similarMovies else {return 0}
        return movies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        
        guard let movies = similarMovies else {return cell}
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 3) - 16, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 8, bottom: 10, right: 8)
    }
}


//  MARK: Netowork call
extension ViewController{
    func loadMovie() async{
        do{
            let movie = try await self.movieService.fetchMovie(id: movieID)
            self.movie = movie
        } catch{
            
        }
    }
    
    func loadSimilarMovies() async{
        do{
            let similarMovies = try await self.movieService.fetchSimilarMovies(id: movieID)
            self.similarMovies = similarMovies
            collectionView.reloadData()
        } catch{
            
        }
    }
    
}

