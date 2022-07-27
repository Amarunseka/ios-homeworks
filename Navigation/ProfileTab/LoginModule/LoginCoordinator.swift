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
    
    
    func segueToProfile(login: String){
        let child = ProfileCoordinator(navigationController: navigationController, userName: login)
        childCoordinators.append(child)
        child.start()
        child.parentCoordinator = self
    }
    
    
    func segueToCreateNewUser(){
        let child = CreateNewUserCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.start()
        child.parentCoordinator = self
    }
}


