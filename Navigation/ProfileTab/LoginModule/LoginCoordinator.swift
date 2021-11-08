//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Миша on 08.11.2021.
//

import UIKit

class LoginCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    
    var userName: String?
    
    private let module = ModuleFactory.createLoginModule()
    
    
    func start() {
        module.viewModel.coordinator = self
        module.tabBarItem = UITabBarItem.createCustomItem(title: "Profile", image: "Computer")
        navigationController.pushViewController(module, animated: true)
    }
    
    
    func segueToProfile(){
        guard let userName = userName else {return}
        
        let child = ProfileCoordinator(navigationController: navigationController, userName: userName)
        childCoordinators.append(child)
        child.start()
        child.parentCoordinator = self
    }
}


// MARK: - Extension remove Child
extension LoginCoordinator {
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
