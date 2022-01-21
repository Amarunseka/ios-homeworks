//
//  MainTabBarViewController.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let feedCoordinator = FeedCoordinator(navigationController: UINavigationController())
    let loginCoordinator = LoginCoordinator()

    override func viewDidLoad() {
        super.viewDidLoad()
        loginCoordinator.start()
        feedCoordinator.start()

        
        viewControllers = [
            loginCoordinator.navigationController,
            feedCoordinator.navigationController]
    }
}
