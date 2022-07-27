//
//  CreateModuleProtocol.swift
//  Navigation
//
//  Created by Миша on 08.11.2021.
//

import UIKit


protocol CreateModuleProtocol {

    static func createFeedModule() -> FeedViewController
    
    static func createPostModule() -> PostViewController
    
    static func createLoginModule() -> LogInViewController
    
    static func createProfileCoordinator(user: String) -> SlideMenuContainerViewController
    
    static func createNewUserModule() -> CreateNewUserViewController
    
    static func createFavoritesModule() -> FavoritesViewController
}
