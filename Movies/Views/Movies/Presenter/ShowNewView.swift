//
//  ShowNewView.swift
//  Movies
//
//  Created by Rafael Oliveira on 19/07/22.
//

import Foundation
import UIKit

typealias ShowNewViewDelegate = ShowPresenterDelegate & UIViewController

protocol ShowPresenterDelegate: AnyObject{
    func setNewView(movieID: Int) -> UIViewController
}

class ShowNewViewPresenterDelegate: ShowNewViewDelegate{
 
    weak var delegate: ShowNewViewDelegate?
    
    func setNewView(movieID: Int) -> UIViewController {
        
    }
    
    public func setViewDelegate(delegate: MoviesDelegate){
        self.delegate = delegate
    }
}
