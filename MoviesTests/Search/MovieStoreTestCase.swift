//
//  MovieServiceTestCase.swift
//  MoviesTests
//
//  Created by Rafael Oliveira on 18/07/22.
//

import Foundation
@testable import Movies
import XCTest


class MovieStoreTestCase: XCTestCase{

    var sut: MovieStore!
    var mockLoadURLAndDecode: MockLoandURLAndDecode!
    
    override func setUp() {
        sut = MovieStore.shared
        mockLoadURLAndDecode = MockLoandURLAndDecode(url: "", params: nil)
    }
    
    override func tearDown() {
        sut = nil
        mockLoadURLAndDecode = nil
    }
    
    func test() async throws{
        
        let result = try await sut.searchMovie(query: "")
        
        XCTAssertThrowsError(MovieError.apiError)
    }
}

