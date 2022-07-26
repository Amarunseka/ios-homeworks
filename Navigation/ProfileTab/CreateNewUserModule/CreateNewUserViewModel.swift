//
//  CreateNewUserViewModel.swift
//  Navigation
//
//  Created by Миша on 02.03.2022.
//

import Foundation
import Firebase
import UIKit

class CreateNewUserViewModel {
    weak var coordinator: CreateNewUserCoordinator?
    
    func createNewUser(email: String, login: String, password: String, controller: UIViewController){
        controller.navigationController?.isNavigationBarHidden = true
        guard password.count >= 6 else {
            controller.present(ShowAlert.showAlert("Пароль должен содержать как минимум 6 символов"), animated: true)
            return
        }
        
        Firebase.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else {return}

            guard error == nil else {
                controller.present(ShowAlert.showAlert("Account creation failed"), animated: true)
                return
            }
            UserDefaultsStorage.shared.saveUser(
                login: login,
                email: email)
            
            self.coordinator?.segueToProfile(email: UserDefaultsStorage.shared.users[email]?.login ?? "Default")
        }
    }
}


