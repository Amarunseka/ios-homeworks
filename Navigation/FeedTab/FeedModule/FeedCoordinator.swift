//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Миша on 08.11.2021.
//

import UIKit

class FeedCoordinator: Coordinator {
    lazy var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private let module = ModuleFactory.createFeedModule()
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        module.viewModel.coordinator = self
        module.tabBarItem = UITabBarItem.createCustomItem(title: "Feed", image: "videoGame")
        navigationController.pushViewController(module, animated: true)
    }

    
    func segueToPost(){
        let child = PostCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.start()
        child.parentCoordinator = self
    }
}
