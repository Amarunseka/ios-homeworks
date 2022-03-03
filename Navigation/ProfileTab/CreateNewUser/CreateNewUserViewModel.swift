//
//  CreateNewUserViewModel.swift
//  Navigation
//
//  Created by Миша on 02.03.2022.
//

import Foundation
import Firebase

class CreateNewUserViewModel {
    weak var coordinator: CreateNewUserCoordinator?

    func createNewUser(email: String, login: String, password: String){
        Firebase.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let strongSelf = self else {return}

            guard error == nil else {
                print("Account creation failed")
                return
            }

            UserStorage.shared.saveUser(
                login: login,
                email: email)

            strongSelf.coordinator?.segueToProfile(email: UserStorage.shared.users[email]?.login ?? "Default")
        }
    }
}


