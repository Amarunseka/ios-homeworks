//
//  PostCoordinator.swift
//  Navigation
//
//  Created by Миша on 08.11.2021.
//

import UIKit

class PostCoordinator: Coordinator {
    weak var parentCoordinator: FeedCoordinator?
    lazy var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private let module = ModuleFactory.createPostModule()

    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    
    func start() {
        module.viewModel.coordinator = self
        navigationController.pushViewController(module, animated: true)
    }
    
    
    func presentToInfo() {
        let infoVC = InfoViewController()
        navigationController.present(infoVC, animated: true, completion: nil)
    }
}


extension PostCoordinator {

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
