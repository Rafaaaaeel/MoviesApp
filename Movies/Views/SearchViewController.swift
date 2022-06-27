//
//  SearchViewController.swift
//  MovieSearchClone
//
//  Created by Rafael Oliveira on 13/06/22.
//

import UIKit

class SearchViewController: UIViewController, ViewFunctions, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {


    var movies: [Movie]?
    
    private var movieservice = MovieStore.shared

    private lazy var searchMovieTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.placeholder = "Search"
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .systemBackground
        textField.clipsToBounds = true
        textField.layer.borderWidth = 1
        textField.leftViewMode = .always
    
        let image = UIImage(systemName: "magnifyingglass")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .darkGray
        textField.leftView = imageView
        textField.layer.backgroundColor = CGColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.indentifier)
        tableView.rowHeight = SearchTableViewCell.rowHeight
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }

}

extension SearchViewController{
    func setupHiearchy() {
        view.addSubview(searchMovieTextField)
        view.addSubview(tableView)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            searchMovieTextField.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0),
            searchMovieTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: searchMovieTextField.trailingAnchor, multiplier: 1),
            searchMovieTextField.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: searchMovieTextField.bottomAnchor, multiplier: 2),
            tableView.leadingAnchor.constraint(equalTo: searchMovieTextField.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: searchMovieTextField.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    
    }
    
    func additional() {
        searchMovieTextField.becomeFirstResponder()
    }
    
    func loadData() async{
//        searchMovieTextField.resignFirstResponder()
        
        guard let text = searchMovieTextField.text, !text.isEmpty else {return}
        
        do{
            let movies = try await movieservice.searchMovie(query: text)
            self.movies = movies
            self.tableView.reloadData()
        }catch{
            
        }
    }
    
}



extension SearchViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let count = movies?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.indentifier, for: indexPath) as! SearchTableViewCell
        
        guard let movies = self.movies else {return cell}
        
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let movie = self.movies else { return }
        
        let vc = ViewController(movieID: movie[indexPath.row].id)
        vc.modalPresentationStyle = .popover
        present(vc, animated: true)
        
        print()
    }
    

}

extension SearchViewController {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        Task{
//            await loadData()
//        }
//        return true
//    }

    
//    Searching in real time, turned off for now, turn on later 
    func textFieldDidChangeSelection(_ textField: UITextField) {
        Task{
            await loadData()
        }
    }
}
