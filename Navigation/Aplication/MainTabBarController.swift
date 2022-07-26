//
//  MainTabBarViewController.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private var coreDataCoordinator: CoreDataCoordinator
    
    private let feedCoordinator = FeedCoordinator(navigationController: UINavigationController())
    private lazy var loginCoordinator = LoginCoordinator(coreDataCoordinator: coreDataCoordinator)
    private lazy var favoritesCoordinator = FavoritesCoordinator(navigationController: UINavigationController(), coreDataCoordinator: coreDataCoordinator)

    init(coreDataCoordinator: CoreDataCoordinator) {
        self.coreDataCoordinator = coreDataCoordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginCoordinator.start()
        feedCoordinator.start()
        favoritesCoordinator.start()
        
        viewControllers = [
            loginCoordinator.navigationController,
            favoritesCoordinator.navigationController,
            feedCoordinator.navigationController
            ]
    }
}
