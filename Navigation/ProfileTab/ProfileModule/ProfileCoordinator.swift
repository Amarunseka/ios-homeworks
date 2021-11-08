//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Миша on 08.11.2021.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    var userName: String
    
    init(navigationController:UINavigationController, userName: String){
        self.navigationController = navigationController
        self.userName = userName
    }
    
    func start() {
        let vm = ProfileViewModel(inputUserName: userName)
        let vc = ProfileViewController(viewModel: vm)
        print("4")
        vm.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    func segueToGallery() {
        let photoViewController = PhotosViewController()
        navigationController.pushViewController(photoViewController, animated: true)}

}
