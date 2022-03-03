//
//  CurrentUser.swift
//  Navigation
//
//  Created by Миша on 15.09.2021.
//

import Foundation
import UIKit

class CurrentUserService: UserServiceProtocol {
    
    private var user: String
    private var currentUser: User
    
    init(user:String){
        self.user = user
        currentUser = User(
            userName: user,
            userAvatar: UIImage(named: "honeybadger") ?? UIImage(),
            userStatus: "Looking to fress somebody")
    }
    
    func createUser(userName: String) -> User? {
        
        guard userName == currentUser.userName else { return nil }
            return currentUser
        }
}
