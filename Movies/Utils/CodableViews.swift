//
//  ViewFunctions.swift
//  MovieSearchClone
//
//  Created by Rafael Oliveira on 01/06/22.
//

import Foundation


public protocol CodableViews {
    func setup()
    func setupHiearchy()
    func setupContraints()
    func additional()
}

extension CodableViews{
    func setup(){
        setupHiearchy()
        setupContraints()
        additional()
    }
    
    func additional() { }
}
