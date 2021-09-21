//
//  CurrentUser.swift
//  Navigation
//
//  Created by Миша on 17.09.2021.
//

import Foundation
import UIKit

class CurrentUserService: UserServiceProtocol {
    
    private var currentUser = User(
        userName: "Amarunseka",
        userAvatar: UIImage(named: "honeybadger") ?? UIImage(),
        userStatus: "Looking to fress somebody")
    
    func createUser(userName: String) -> User? {
        
        guard userName == currentUser.userName else { return nil }
            return currentUser
        }
}
