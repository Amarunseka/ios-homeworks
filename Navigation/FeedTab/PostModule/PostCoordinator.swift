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
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let vm = PostViewModel()
        let vc = PostViewController(model: vm)
        vm.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    func presentToInfo() {
        let infoVC = InfoViewController()
        navigationController.present(infoVC, animated: true, completion: nil)
    }
}
