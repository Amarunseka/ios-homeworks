//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Миша on 08.11.2021.
//

import UIKit

class FeedCoordinator: NSObject, Coordinator {
    lazy var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    let checkerText = CheckText()
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    
    func start() {
        let vm = FeedViewModel(checkerText: checkerText)
        let vc = FeedViewController(viewModel: vm)
        
        vm.coordinator = self
        vc.tabBarItem = UITabBarItem.createCustomItem(title: "Feed", image: "videoGame")
        navigationController.pushViewController(vc, animated: true)
        navigationController.delegate = self
    }

    
    func segueToPost(){
        let child = PostCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.start()
        child.parentCoordinator = self
    }
}



// MARK: - Extension remove Child
extension FeedCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {return}
        
        if navigationController.viewControllers.contains(fromViewController) {return}
        
        if let postViewController = fromViewController as? PostViewController {
            childDidFinish(postViewController.coordinator)
        }
    }

    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

