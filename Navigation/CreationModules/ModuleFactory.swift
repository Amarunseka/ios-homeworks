//
//  CreateModuleFabric.swift
//  Navigation
//
//  Created by Миша on 08.11.2021.
//

import UIKit

class ModuleFactory: CreateModuleProtocol {

    static func createFeedModule() -> FeedViewController {
        let checkerText = CheckText()
        let vm = FeedViewModel(checkerText: checkerText)
        let vc = FeedViewController(viewModel: vm)
        return vc
    }
    
    
    static func createPostModule() -> PostViewController {
        let vm = PostViewModel()
        let vc = PostViewController(model: vm)
        return vc
    }
    
    
    static func createLoginModule() -> LogInViewController {
        let loginFactory = LoginFactory()
        let vm = LoginViewModel(delegate: loginFactory.createLoginInspector())
        let vc = LogInViewController(viewModel: vm)
        return vc
    }
    
    static func createProfileCoordinator(user: String) -> SlideMenuContainerViewController {
        let vm = ProfileViewModel(inputUserName: user)
        let menuVC = SlideMenuViewController()
        let profileVC = ProfileViewController(viewModel: vm)
        let containerVC = SlideMenuContainerViewController(menuVC: menuVC, profileVC: profileVC)
        return containerVC
    }
    
    static func createNewUserModule() -> CreateNewUserViewController {
        let vm = CreateNewUserViewModel()
        let vc = CreateNewUserViewController(viewModel: vm)
        return vc
    }
    
    static func createFavoritesModule() -> FavoritesViewController {
        let vm = FavoritesViewModel()
        let vc = FavoritesViewController(viewModel: vm)
        return vc
    }
}
