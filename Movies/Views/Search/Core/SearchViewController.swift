//
//  NewSearchViewController.swift
//  Movies
//
//  Created by Rafael Oliveira on 25/06/22.
//

import UIKit
import SkeletonView


class SearchViewController: UIViewController, ViewFunctions, UICollectionViewDelegateFlowLayout, SkeletonCollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate{

    

    var movies: [Movie]?
    private var movieservice = MovieStore.shared
    
    
//  MARK: - UI Components
    
    private lazy var searchMovieTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.placeholder = "Search"
        textField.clipsToBounds = true
        textField.layer.borderWidth = 1
        textField.leftViewMode = .always
    
        textField.tintColor = .white
        let image = UIImage(systemName: "magnifyingglass")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .darkGray
        textField.leftView = imageView
        textField.layer.backgroundColor = UIColor.systemBackground.cgColor
        return textField
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
        cv.register(SearchMoviesCollectionViewCell.self, forCellWithReuseIdentifier: SearchMoviesCollectionViewCell.identifier)
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
//  MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        SkeletonAppearance.default.skeletonCornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = true;
    }
    
}

//  MARK: - View Functions

extension SearchViewController {
    func setupHiearchy() {
        
        view.addSubview(searchMovieTextField)
        view.addSubview(collectionView)
        view.sendSubviewToBack(collectionView)
    }
    
    func setupContraints() {
        
        NSLayoutConstraint.activate([
            searchMovieTextField.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0),
            searchMovieTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchMovieTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalToSystemSpacingBelow: searchMovieTextField.bottomAnchor, multiplier: 2),
            collectionView.leadingAnchor.constraint(equalTo: searchMovieTextField.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func additional() {
        searchMovieTextField.becomeFirstResponder()
        collectionView.keyboardDismissMode = .onDrag
        navigationItem.hidesBackButton = true
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .label
    }
    
}


//  MARK: - Collection Delegate & Data Source

extension SearchViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let movies = movies else {return 0}
        return movies.count
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return SearchMoviesCollectionViewCell.identifier
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchMoviesCollectionViewCell.identifier, for: indexPath) as! SearchMoviesCollectionViewCell
        
        guard let movies = movies else {return cell}
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 3) - 16, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 8, bottom: 5, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let movie = self.movies else { return }
        
        print(movie[indexPath.row].genreIds!)
        
        let vc = MovieViewController(movieID: movie[indexPath.row].id)
        self.navigationController?.pushViewController(vc, animated: true )
    
    }
}

//  MARK: Network api call

extension SearchViewController {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        collectionView.isSkeletonable = true
        collectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .darkGray), animation: nil, transition: .crossDissolve(0.25))
        Task{
            await loadData()
    
        }
        
    }
    
    
    func loadData() async{
        guard let text = searchMovieTextField.text, !text.isEmpty else {return}
        
        do{
            let movies = try await movieservice.searchMovie(query: text)
            self.movies = movies
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.collectionView.stopSkeletonAnimation()
                self.view.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(0.25))
            }
            self.collectionView.reloadData()
        }catch{
            print("Error")
        }
    }
}


