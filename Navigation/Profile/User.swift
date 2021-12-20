//
//  User.swift
//  Navigation
//
//  Created by Миша on 14.09.2021.
//

import Foundation
import UIKit

class User {
    
    let userName: String
    let userAvatar: UIImage
    let userStatus: String
    
    init(userName: String, userAvatar: UIImage, userStatus: String) {
        
        self.userName = userName
        self.userAvatar = userAvatar
        self.userStatus = userStatus
    }
}
