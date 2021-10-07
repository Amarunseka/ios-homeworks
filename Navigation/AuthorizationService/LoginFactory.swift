//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by Миша on 20.09.2021.
//

import Foundation

class LoginFactory: LoginFactoryProtocol {
    func createLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
