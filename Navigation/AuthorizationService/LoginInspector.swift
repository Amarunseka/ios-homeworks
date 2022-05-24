//
//  LoginInspector.swift
//  Navigation
//
//  Created by Миша on 20.09.2021.
//

import Foundation

class LoginInspector: LoginViewControllerDelegateProtocol {
    
    func checkUserAuthentication(email: String, password: String, completion: @escaping (Bool)->Void) {
        return Checker.shared.checkAuthentication(email: email, password: password){ result in
            completion(result)
        }
    }
}
