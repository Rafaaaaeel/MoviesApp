//
//  ViewFunctions.swift
//  MovieSearchClone
//
//  Created by Rafael Oliveira on 01/06/22.
//

import Foundation


public protocol ViewFunctions {
    func setup()
    func setupHiearchy()
    func setupContraints()
    func additional()
}

extension ViewFunctions{
    func setup(){
        setupHiearchy()
        setupContraints()
        additional()
    }
    
    func additional() { }
}
