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

struct Movie: Decodable, Identifiable{
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runTime: Int?
    
    var backdropURL: String {
        return "https://image.tmdb.org/t/p/original/\(backdropPath ?? "nothing")"
    }
    
    var posterURL: String {
        return "https://image.tmdb.org/t/p/w342/\(posterPath ?? "nothing")"
    }
}
