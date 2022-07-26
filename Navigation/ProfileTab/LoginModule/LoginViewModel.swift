//
//  LoginViewModel.swift
//  Navigation
//
//  Created by Миша on 08.11.2021.


import Foundation
import Firebase


class LoginViewModel {
    
    weak var coordinator: LoginCoordinator?
    var delegate: LoginViewControllerDelegateProtocol

    
    init(delegate: LoginViewControllerDelegateProtocol) {
        self.delegate = delegate
    }

    
    func checkCurrentUser(){
        if let user = Firebase.Auth.auth().currentUser,
           let email = user.email {
            coordinator?.segueToProfile(login: UserDefaultsStorage.shared.users[email]?.login ?? "Default")
        }
    }

    
    func checkAuthorization(email: String, password: String, navigation: UIViewController) throws {

        delegate.checkUserAuthentication(email: email, password: password) { [weak self] result in
            guard let self = self else {return}
            if result {
                self.coordinator?.segueToProfile(
                    login: UserDefaultsStorage.shared.users[email]?.login ?? "Default email")
            } else {
                self.showCreateAccount(navigation: navigation)
            }
        }
    }
    
    
    func showCreateAccount(navigation: UIViewController){

        let alert = UIAlertController(
            title: "Account not found",
            message: "Would you like to create an account?",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(
            title: "Continue",
            style: .default,
            handler: { _ in
                
                self.segueToCreateNewUser()
            }))
        
        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: { _ in
            }))
        
        navigation.present(alert, animated: true)
    }

    
    func segueToCreateNewUser(){
        coordinator?.segueToCreateNewUser()
    }
}


