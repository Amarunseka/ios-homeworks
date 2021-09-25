//
//  LoginFactory.swift
//  Navigation
//
//  Created by Миша on 21.09.2021.
//

import Foundation

class LoginFactory: LoginFactoryProtocol {
    func createLoginInspector() -> LoginViewControllerDelegateProtocol {
        return LoginInspector()
    }
}
//
//struct MyLogInFactory: LoginFactory {
//    
//    func makeInspector () -> LogInInspector {
//        return LogInInspector()
//    }