//
//  ViewController.swift
//  MovieSearchClone
//
//  Created by Rafael Oliveira on 04/06/22.
//

import Foundation
import UIKit
import SnapKit


class NewMovieViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    

//    MVVM Model View ViewModel - VIPER && VIP View Interactor P e Router

    var movie: Movie?
    var genres: [Genre]?
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
        image.contentMode = .scaleAspectFill
        return image
    }()
    
//    lazy var genreLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Movie"
//        label.numberOfLines = 0
//        label.textAlignment = .left
//        label.lineBreakMode = .byWordWrapping
//        label.font = UIFont.preferredFont(forTextStyle: .callout)
//        return label
//    }()


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
    
    lazy var addToMyListButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: [])
        button.tintColor = .label
        button.addTarget(self, action: #selector(addToMyList), for: .touchUpInside)
        button.configuration?.buttonSize = .large
        return button
    }()
    
    lazy var addToMyListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My list"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        return label
    }()
    
    lazy var similarMoviesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Similar Titles"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeAllPagesAndReturn))
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        cv.showsVerticalScrollIndicator = false
        cv.frame = self.view.bounds
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
        self.navigationItem.rightBarButtonItem = closeButton
    }
    
}

//  MARK: - View Functions
extension NewMovieViewController: CodableViews{
    func setupHiearchy() {

        view.addSubviews(posterImage,overviewLabel,voteStarImage,addToMyListButton,addToMyListLabel,voteAvaregeLabel,voteAvaregeTotalLabel,similarMoviesLabel)
        
    }
    
    func setupContraints() {

        posterImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottomMargin.equalTo(-200)
        }
        
        voteStarImage.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottomMargin)
        }

    }
    
    func additional() {
        Task{
            await loadMovie()
           
            // Configure
            guard let movie = self.movie else {return}

            self.posterImage.sd_setImage(with: movie.backdropURL)
            self.overviewLabel.text = movie.overview
            self.voteAvaregeLabel.text = String(floor(movie.voteAverage * 10)/10.0)
            self.navigationItem.title = movie.title
        }
        
        Task{
            await loadSimilarMovies()
        }
        Task{
            await loadGenres()
        }
        view.backgroundColor = .systemBackground
    }
}

//  MARK: - Collection Delegate & Data Source
extension NewMovieViewController{
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let movie = self.similarMovies else { return }
        
        let vc = MovieViewController(movieID: movie[indexPath.row].id)
        self.navigationController?.pushViewController(vc, animated: true )
    
    }
}

//  MARK: - Objc Functions

extension NewMovieViewController{
    @objc func closeAllPagesAndReturn(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func addToMyList(){
        
        
        addToMyListButton.setImage(UIImage(systemName: "checkmark"), for: [])
    }
}

//  MARK: Network api call

extension NewMovieViewController{
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
    
    func loadGenres() async{
        do{
            let genres = try await self.movieService.fetchGenres()
            self.genres = genres
        
        }catch{
            
        }
    }
    
}

