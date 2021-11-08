//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Миша on 08.11.2021.
//

import UIKit

class LoginCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    var userName: String?
    var loginFactory = LoginFactory()
    
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    
    func start() {
        let vm = LoginViewModel(delegate: loginFactory.createLoginInspector())
        let vc = LogInViewController(viewModel: vm)
        
        vm.coordinator = self
        vc.tabBarItem = UITabBarItem.createCustomItem(title: "Profile", image: "Computer")
        navigationController.pushViewController(vc, animated: true)
        navigationController.delegate = self
    }
    
    
    func segueToProfile(){
        guard let userName = userName else {return print("n3")}
        
        let child = ProfileCoordinator(navigationController: navigationController, userName: userName)
        childCoordinators.append(child)
        child.start()
        print("3")
        child.parentCoordinator = self
    }
}


// MARK: - Extension remove Child
extension LoginCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {return}
        
        if navigationController.viewControllers.contains(fromViewController) {return}
        
        if let profileViewModel = fromViewController as? ProfileViewModel {
            childDidFinish(profileViewModel.coordinator)
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
