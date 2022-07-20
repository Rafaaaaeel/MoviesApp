//
//  MovieModel.swift
//  MovieSearchClone
//
//  Created by Rafael Oliveira on 04/06/22.
//

import Foundation

// MARK: New code
struct MovieResponse: Decodable{
    let results: [Movie]
}

struct GenreResponse: Decodable{
    let genres: [Genre]
}

struct Movie: Decodable, Identifiable{
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runTime: Int?
    let genreIds: [Int]?
    
    var backdropURL: URL? {
        return URL(string:"https://image.tmdb.org/t/p/original/\(backdropPath ?? "")")
    }
    
    var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w342/\(posterPath ?? "")")
    }
}

struct Genre: Decodable, Identifiable{
    let id: Int
    let name: String
    
}
