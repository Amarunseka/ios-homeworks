//
//  LoginInspector.swift
//  Navigation
//
//  Created by Миша on 21.09.2021.
//

import Foundation

class LoginInspector: LoginViewControllerDelegateProtocol {
    
    func checkUserAuthentication(login: String, password: String) -> Bool {
        return Checker.shared.checkAuthentication(login: login, password: password)
    }
}
