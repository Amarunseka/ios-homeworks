//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Миша on 08.11.2021.
//

import Foundation
import UIKit


class ProfileViewModel {
    
    weak var coordinator: ProfileCoordinator?
    
    var outputUserInfo: User?
    private let inputUserName: String
    var outputAlert: UIAlertController?

    
    
    init(inputUserName: String){
        self.inputUserName = inputUserName
        
        self.createUser {user in
            switch user {
            case.success(let user):
                self.outputUserInfo = user
            case.failure(let error):
                self.outputAlert = ShowAlert.showAlert(error.localizedDescription)
            }
        }
    }
    
    
    private func createUser(completion: @escaping (Result<User, AuthenticationErrors>) -> Void) {
    
        var user: UserServiceProtocol
        
        #if DEBUG
        user = CurrentUserService(user: inputUserName)
        #else
        user = TestUserService()
        #endif
        
        if let user = user.createUser(userName: inputUserName) {
            completion(.success(user))
        } else {
            completion(.failure(.userNotFound))
        }
    }
    
    func segueToGallery(){
        coordinator?.segueToGallery()
    }
}

