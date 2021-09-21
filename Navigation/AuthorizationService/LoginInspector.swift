//
//  LoginInspector.swift
//  Navigation
//
//  Created by Миша on 21.09.2021.
//

import Foundation

class LoginInspector: LoginViewControllerDelegate {
    
    func checkUserAuthentication(login: String, password: String) -> Bool {
        return Checker.data.checkAuthentication(login: login, password: password)
    }
}
