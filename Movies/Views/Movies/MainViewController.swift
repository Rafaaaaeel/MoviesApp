//
//  MainViewController.swift
//  MovieSearchClone
//
//  Created by Rafael Oliveira on 13/06/22.
//

import UIKit

class MainViewController: UIViewController, ViewFunctions, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    
    var item = 10

// MARK: - UI Components
    
    private lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 550)
    
    private lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = contentViewSize
        scrollView.showsVerticalScrollIndicator = false
        scrollView.frame = self.view.bounds
        return scrollView
        
    }()
    
    private lazy var containerView : UIView = {
        let view = UIView()
        view.frame.size = contentViewSize
        return view
    }()

    
    private lazy var screenTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Movies"
        label.font = UIFont.boldSystemFont(ofSize: 34)
        return label
    }()
    
    private lazy var nowPlayingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Now Playing"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private lazy var nowPlayingCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.createLayoutPortrait())
        collection.register(NowPlayingCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .systemBackground
        collection.isScrollEnabled = false
        return collection
    }()
    
    private lazy var upComingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Upcoming"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private lazy var upComingCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.createLayoutLandscape())
        collection.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .systemBackground
        collection.isScrollEnabled = false
        return collection
    }()
    
    private lazy var topRatedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Top Rated"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
 
    private lazy var topRatedCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.createLayoutLandscape())
        collection.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .systemBackground
        collection.isScrollEnabled = false
        return collection
    }()
    
    private lazy var popularLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Popular"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
 
    private lazy var popularCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.createLayoutPortrait())
        collection.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .systemBackground
        collection.isScrollEnabled = false
        return collection
    }()
    
    
    
// MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}


// MARK: - View functions
extension MainViewController{
    func setupHiearchy() {
        
        containerView.addSubview(screenTitleLabel)
        containerView.addSubview(nowPlayingLabel)
        containerView.addSubview(upComingLabel)
        containerView.addSubview(nowPlayingCollectionView)
        containerView.addSubview(upComingCollectionView)
        containerView.addSubview(topRatedLabel)
        containerView.addSubview(topRatedCollectionView)
        
        containerView.addSubview(popularLabel)
        containerView.addSubview(popularCollectionView)
        
        mainScrollView.addSubview(containerView)
        view.addSubview(mainScrollView)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            mainScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            screenTitleLabel.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 8),
            screenTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
        ])
        
        NSLayoutConstraint.activate([
            nowPlayingLabel.topAnchor.constraint(equalTo: screenTitleLabel.bottomAnchor, constant: 16),
            nowPlayingLabel.leadingAnchor.constraint(equalTo: screenTitleLabel.leadingAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            nowPlayingCollectionView.topAnchor.constraint(equalToSystemSpacingBelow: nowPlayingLabel.bottomAnchor, multiplier: 2),
            nowPlayingCollectionView.leadingAnchor.constraint(equalTo: nowPlayingLabel.leadingAnchor),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nowPlayingCollectionView.trailingAnchor, multiplier: 0),
            nowPlayingCollectionView.heightAnchor.constraint(equalToConstant: 340)
        ])
        
        NSLayoutConstraint.activate([
            upComingLabel.topAnchor.constraint(equalToSystemSpacingBelow: nowPlayingCollectionView.bottomAnchor, multiplier: 1),
            upComingLabel.leadingAnchor.constraint(equalTo: nowPlayingLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            upComingCollectionView.topAnchor.constraint(equalToSystemSpacingBelow: upComingLabel.bottomAnchor, multiplier: 2),
            upComingCollectionView.leadingAnchor.constraint(equalTo: upComingLabel.leadingAnchor),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: upComingCollectionView.trailingAnchor, multiplier: 0),
            upComingCollectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
        NSLayoutConstraint.activate([
            topRatedLabel.topAnchor.constraint(equalToSystemSpacingBelow: upComingCollectionView.bottomAnchor, multiplier: 1),
            topRatedLabel.leadingAnchor.constraint(equalTo: nowPlayingLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            topRatedCollectionView.topAnchor.constraint(equalToSystemSpacingBelow: topRatedLabel.bottomAnchor, multiplier: 2),
            topRatedCollectionView.leadingAnchor.constraint(equalTo: topRatedLabel.leadingAnchor),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: topRatedCollectionView.trailingAnchor, multiplier: 0),
            topRatedCollectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            popularLabel.topAnchor.constraint(equalToSystemSpacingBelow: topRatedCollectionView.bottomAnchor, multiplier: 1),
            popularLabel.leadingAnchor.constraint(equalTo: nowPlayingLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            popularCollectionView.topAnchor.constraint(equalToSystemSpacingBelow: popularLabel.bottomAnchor, multiplier: 2),
            popularCollectionView.leadingAnchor.constraint(equalTo: popularLabel.leadingAnchor),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: popularCollectionView.trailingAnchor, multiplier: 0),
            popularCollectionView.heightAnchor.constraint(equalToConstant: 340)
        ])
    }
    
    func additional() {
        
    }
    
}


// MARK: - Collection Data source & Delegate
extension MainViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath)
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        
//    }
    
}


// MARK: - Collection View layout
extension MainViewController{
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
        section.orthogonalScrollingBehavior = .groupPaging
        return UICollectionViewCompositionalLayout(section: section)
    }

    
    func createLayoutPortrait() -> UICollectionViewCompositionalLayout{
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.6),
                heightDimension: .fractionalWidth(1.5)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.6),
                heightDimension: .fractionalWidth(1.5)
            ),
            subitem: item,
            count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func registerCollectionViewCells(collectionView: UICollectionView) {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(MyCollectionViewCell.self,forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        collectionView.register(NowPlayingCollectionViewCell.self,forCellWithReuseIdentifier: NowPlayingCollectionViewCell.identifier)
//        collectionView.register(RecommendedTrackCollectionViewCell.self,forCellWithReuseIdentifier: RecommendedTrackCollectionViewCell.identifier)
    }
}
