//
//  NewMainCollectionViewCell.swift
//  MovieSearchClone
//
//  Created by Rafael Oliveira on 17/06/22.
//

import UIKit

class NewMainViewController: UIViewController, ViewFunctions {

    
    private lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 550)
    
    private lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = contentViewSize
        scrollView.showsVerticalScrollIndicator = false
        scrollView.frame = self.view.bounds
        return scrollView
        
    }()
    
    private lazy var containerView : UIView = {
        let view = UIView()
        view.frame.size = contentViewSize
        return view
    }()
    
    private lazy var screenTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Movies"
        label.font = UIFont.boldSystemFont(ofSize: 34)
        return label
    }()
    
    private lazy var nowPlayingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Now Playing"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}


extension NewMainViewController{
    func setupHiearchy() {
        //
    }
    
    func setupContraints() {
        //
    }
    
}
