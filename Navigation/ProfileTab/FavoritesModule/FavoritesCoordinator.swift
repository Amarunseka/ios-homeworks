//
//  FavoritesCoordinator.swift
//  Navigation
//
//  Created by Миша on 26.07.2022.
//

import UIKit

class FavoritesCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var module: FavoritesViewController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        self.module = ModuleFactory.createFavoritesModule()
    }
    
    func start() {
        module.tabBarItem = UITabBarItem.createCustomItem(title: "Favorites", image: "favorites")
        module.viewModel.coordinator = self
        navigationController.pushViewController(module, animated: true)
    }
}
