//
//  MainTabBarViewController.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedVC = generateVC(vc: FeedViewController(), title: "Feed", imageName: "027-video game")
        let postVC = generateVC(vc: LogInViewController(), title: "Profile", imageName: "033-computer")

        viewControllers = [feedVC, postVC]
    }

    func generateVC(vc: UIViewController, title: String, imageName: String) -> UINavigationController {
        vc.navigationItem.title = title
        let controller = UINavigationController(rootViewController: vc)
        controller.title = title
        
        if let image = UIImage(named: imageName) {
        controller.tabBarItem.selectedImage = image.withRenderingMode(.alwaysOriginal)
        controller.tabBarItem.image = image.withRenderingMode(.alwaysTemplate)}
        return controller
    }
}
