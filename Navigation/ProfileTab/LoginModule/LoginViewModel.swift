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

    
    // MARK: - ДЗ-11 Задача №1 (1)
    func checkAuthorization(login: String, password: String) throws {

        var user: [String] = []

        if login.count > 0, password.count > 0 {
            user.append(login)
            user.append(password)
        } else if login.count <= 0 {
            throw AuthenticationErrors.loginIsEmpty
        } else if password.count <= 0 {
            throw AuthenticationErrors.passwordIsEmpty
        }


        if delegate.checkUserAuthentication(login: user[0], password: user[1]) {
            coordinator?.userName = user[0]
        } else {
            throw AuthenticationErrors.userNotFound
        }
    }
    
    
    func segueToProfile() {
        coordinator?.segueToProfile()
    }
}

