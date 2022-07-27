//
//  SlideMenuCoordinator.swift
//  Navigation
//
//  Created by Миша on 21.12.2021.
//

import UIKit

class SlideMenuCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    private var userName: String
    private var coreDataCoordinator: CoreDataCoordinator
    private lazy var module = ModuleFactory.createProfileCoordinator(user: userName)

    
    init(navigationController:UINavigationController, userName: String, coreDataCoordinator: CoreDataCoordinator){
        self.navigationController = navigationController
        self.userName = userName
        self.coreDataCoordinator = coreDataCoordinator
    }
    
    func start() {
        navigationController.pushViewController(module, animated: true)
    }
    
    
    func segueToGallery() {
        let photoViewController = PhotosViewController()
        navigationController.pushViewController(photoViewController, animated: true)}
}
