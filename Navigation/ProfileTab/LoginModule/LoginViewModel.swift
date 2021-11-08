//
//  LoginViewModel.swift
//  Navigation
//
//  Created by Миша on 08.11.2021.
//

import Foundation


class LoginViewModel {
    
    weak var coordinator: LoginCoordinator?
    var delegate: LoginViewControllerDelegateProtocol
    
    init(delegate: LoginViewControllerDelegateProtocol) {
        self.delegate = delegate
    }

    
    func checkAuthorization(login: String, password: String) -> Bool {
        
        if delegate.checkUserAuthentication(login: login, password: password) {
            coordinator?.userName = login
            return true
        } else {
            return false
        }
    }
    
    
    func segueToProfile() {
        coordinator?.segueToProfile()
    }
}
