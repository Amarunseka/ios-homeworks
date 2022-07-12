//
//  UserRealmModel.swift
//  Navigation
//
//  Created by Миша on 12.07.2022.
//

import Foundation
import RealmSwift

class UserRealmModel: Object {
    @Persisted var userLogin: String
    @Persisted var userEmail: String
    @Persisted var userPassword: String
    
    convenience init(userLogin: String, userEmail: String, userPassword: String) {
        self.init()
        self.userLogin = userLogin
        self.userEmail = userEmail.lowercase
        self.userPassword = userPassword
    }
}
