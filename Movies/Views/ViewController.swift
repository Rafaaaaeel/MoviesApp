//
//  ViewController.swift
//  Movies
//
//  Created by Rafael Oliveira on 28/06/22.
//

import UIKit

class ViewController: UIViewController, ViewFunctions, UITableViewDelegate, UITableViewDataSource {

    var genres: [Genre]?
    var movieService = MovieStore.shared

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .red
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setup()
        
    
    }


}

extension ViewController{
    func setupHiearchy() {
        
        guard let genre = self.genres else {return}
        print(genre[0].name)
    }
    
    func setupContraints() {
        tableView.frame = view.bounds
        
    }
    func additional() {
        Task{
            await loadGenres()
            
        }
    }
    
}

extension ViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let genre = self.genres else {return 0}
        return genre.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard let genre = self.genres else {return cell}
        cell.textLabel?.text = genre[indexPath.row].name
        
        return cell
    }
}


extension ViewController{
    func loadGenres() async{
        do{
            let generes = try await movieService.fetchGenres()
            self.genres = generes
            self.tableView.reloadData()
        }catch{
            
        }
    }
}
