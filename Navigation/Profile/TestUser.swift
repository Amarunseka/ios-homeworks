//
//  TestUser.swift
//  Navigation
//
//  Created by Миша on 17.09.2021.
//

import Foundation
import UIKit

class TestUserService: UserServiceProtocol {
    
    private var currentUser = User(
        userName: "Test",
        userAvatar: UIImage(named: "Testing") ?? UIImage(),
        userStatus: "Testing right now")
    
    func createUser(userName: String) -> User? {
        
        guard userName == currentUser.userName else { return nil }
            return currentUser
        }
}
