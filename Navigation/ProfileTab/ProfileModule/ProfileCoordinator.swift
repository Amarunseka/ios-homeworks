//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Миша on 08.11.2021.
//

import UIKit

class ProfileCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    var userName: String
    private var coreDataCoordinator: CoreDataCoordinator
    private lazy var module = ModuleFactory.createProfileCoordinator(user: userName, coreDataCoordinator: coreDataCoordinator)

    
    init(navigationController: UINavigationController, userName: String, coreDataCoordinator: CoreDataCoordinator){
        self.navigationController = navigationController
        self.userName = userName
        self.coreDataCoordinator = coreDataCoordinator
    }
    
    func start() {
        module.profileVC.viewModel.coordinator = self
        navigationController.pushViewController(module, animated: true)
    }
    
    
    func segueToGallery() {
        let photoViewController = PhotosViewController()
        navigationController.pushViewController(photoViewController, animated: true)}
}

