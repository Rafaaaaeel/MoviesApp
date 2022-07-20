//
//  MockLoadURLAndDecoce.swift
//  MoviesTests
//
//  Created by Rafael Oliveira on 18/07/22.
//

import Foundation

class MockLoandURLAndDecode{
    
    var url: String
    var params: [String: String]?
    
    init(url: String, params: [String: String]? = nil) {
        self.url = url
    }
}
