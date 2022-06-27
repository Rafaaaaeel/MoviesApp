//
//  AppDelegate.swift
//  MovieSearchClone
//
//  Created by Rafael Oliveira on 01/06/22.
//

import UIKit

    @main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let tabBarList = UITabBarController()
    let searchViewController = SearchViewController()
    let moviesViewController = MoviesViewController()
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
    
        searchViewController.setTabBarImage(imageName: "magnifyingglass", title: "Search")
        moviesViewController.setTabBarImage(imageName: "ticket", title: "Movies")
        
//        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        let mainNavigationController = UINavigationController(rootViewController: moviesViewController)
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        mainNavigationController.title = "Movies"
        
        tabBarList.viewControllers = [mainNavigationController,searchNavigationController]
        
        window?.rootViewController = tabBarList
        
        return true
    }


}

