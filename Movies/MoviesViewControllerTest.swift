//
//  ViewController.swift
//  MovieSearchClone
//
//  Created by Rafael Oliveira on 01/06/22.
//

import UIKit


// MARK: - Model


// MARK: - View
class MoviesViewControllerTest: UIViewController, ViewFunctions, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

//  MARK: - UI Components
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var searchMoviesTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Search"
        return textField
    }()
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

}

// MARK: - View Functions
extension MoviesViewControllerTest{
    func setupHiearchy() {
        view.addSubview(searchMoviesTextField)
        view.addSubview(tableView)
    }
    
    func setupContraints() {
        
        // Search textField
        NSLayoutConstraint.activate([
            searchMoviesTextField.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            searchMoviesTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: searchMoviesTextField.trailingAnchor, multiplier: 2),
        ])
        
        // TableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchMoviesTextField.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: searchMoviesTextField.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: searchMoviesTextField.bottomAnchor),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: tableView.trailingAnchor, multiplier: 2)
        ])
    }
        
    func additional() {
        tableView.delegate = self
        tableView.dataSource = self
        searchMoviesTextField.delegate = self
    }

}

// MARK: - Data source Delegate
extension MoviesViewControllerTest{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
}

// MARK: - Newtork function
