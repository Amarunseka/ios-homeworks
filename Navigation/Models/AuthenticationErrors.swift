//
//  LoginAutothincationErrors.swift
//  Navigation
//
//  Created by Миша on 03.12.2021.
//

import Foundation

enum AuthenticationErrors: Error {
    case loginIsEmpty
    case passwordIsEmpty
    case userNotFound
    
    var localizedDescription: String {
        switch self {
        case .loginIsEmpty:
            return "Небходимо ввести логин"
        case .passwordIsEmpty:
            return "Небходимо ввести пароль"
        case .userNotFound:
            return "Такой пользователь не найден"

        }
    }
}
