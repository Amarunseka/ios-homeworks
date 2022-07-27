//
//  CreateNewUserCoordinator.swift
//  Navigation
//
//  Created by Миша on 02.03.2022.
//

import UIKit

class CreateNewUserCoordinator: Coordinator {
    
    weak var parentCoordinator: LoginCoordinator?
    lazy var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private let module = ModuleFactory.createNewUserModule()

    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    
    func start() {
        module.viewModel.coordinator = self
        navigationController.pushViewController(module, animated: true)
    }
    
    func segueToProfile(email: String){
        let child = ProfileCoordinator(navigationController: navigationController, userName: email)
        childCoordinators.append(child)
        child.start()
        child.parentCoordinator = self
    }
}
