//
//  MovieListState.swift
//  MovieSearchClone
//
//  Created by Rafael Oliveira on 22/06/22.
//

import Foundation

class MovieListState {
    
    var movies: [Movie]?
    var isLoading = false
    var error: NSError?
    
    private let movieService: MovieService
    
    init(movieService: MovieService = MovieStore.shared){
        self.movieService = movieService
    }
    
    func loadMovies(with endpoint: MovieListEndpoint) async {
        
        do{
            let movies = try await movieService.fetchMovies(from: endpoint)
            self.movies = movies
         } catch{
            
        }
    }
}
