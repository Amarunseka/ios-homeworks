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
    
    var password: String?
    var foundedPassword: String?
    lazy var bruteForce = BruteForce()
    
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
        if password == foundedPassword && password != nil {
            coordinator?.userName = "Test" // для бутфорс
            coordinator?.segueToProfile()
        }
    }
    
    
    func generatePassword(){
        var tempPassword = ""
        let storage = [
            "1", "2", "3", "4", "5", "6", "7", "8", "9",
            "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",]
        
        for _ in 0..<1 {
            if let char = storage.randomElement() {
                tempPassword += char
            }
        }
        password = tempPassword
    }
    
    
    func findPassword(){
        guard
            let password = password,
            password.count > 0
        else {return}
        foundedPassword = bruteForce.bruteForce(passwordToUnlock: password)
    }
}
