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
    
    var userName: String
    private lazy var module = ModuleFactory.createProfileCoordinator(user: userName)

    
    init(navigationController:UINavigationController, userName: String){
        self.navigationController = navigationController
        self.userName = userName
    }
    
    func start() {
        //module.profileVC.viewModel.coordinator = self
        navigationController.pushViewController(module, animated: true)
    }
    
    
    func segueToGallery() {
        let photoViewController = PhotosViewController()
        navigationController.pushViewController(photoViewController, animated: true)}
}
