//
//  MainTabBarViewController.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let checker = CheckText()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedNVC = generateVC(vc: FeedViewController(checkerText: checker),
                                 title: "Feed",
                                 imageName: "027-video game")
        
        let loginNVC = generateVC(vc: LogInViewController(),
                                  title: "Profile",
                                  imageName: "033-computer")
        
        if let loginVC = loginNVC.viewControllers.first as? LogInViewController {
            let loginFactory = LoginFactory()
            loginVC.delegate = loginFactory.createLoginInspector()
        }
        
        viewControllers = [feedNVC, loginNVC]
    }
    
    private func generateVC(vc: UIViewController, title: String, imageName: String) -> UINavigationController {
        vc.navigationItem.title = title
        let controller = UINavigationController(rootViewController: vc)
        controller.title = title
        
        if let image = UIImage(named: imageName) {
            controller.tabBarItem.selectedImage = image.withRenderingMode(.alwaysOriginal)
            controller.tabBarItem.image = image.withRenderingMode(.alwaysTemplate)}
        return controller
    }
}
