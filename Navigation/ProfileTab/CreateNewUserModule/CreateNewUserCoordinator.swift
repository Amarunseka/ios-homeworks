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
    private let coreDataCoordinator: CoreDataCoordinator

    
    init(navigationController: UINavigationController, coreDataCoordinator: CoreDataCoordinator){
        self.navigationController = navigationController
        self.coreDataCoordinator = coreDataCoordinator
    }
    
    
    func start() {
        module.viewModel.coordinator = self
        navigationController.pushViewController(module, animated: true)
    }
    
    func segueToProfile(email: String){
        let child = ProfileCoordinator(navigationController: navigationController, userName: email, coreDataCoordinator: coreDataCoordinator)
        childCoordinators.append(child)
        child.start()
        child.parentCoordinator = self
    }
}
