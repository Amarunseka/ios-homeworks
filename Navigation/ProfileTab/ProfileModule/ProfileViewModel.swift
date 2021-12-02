//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Миша on 08.11.2021.
//

import Foundation


class ProfileViewModel {
    
    weak var coordinator: ProfileCoordinator?
    
    var outputUserInfo: User?
    private let inputUserName: String
    
    
    init(inputUserName: String){
        self.inputUserName = inputUserName
        self.createUser()
    }
    
    
    private func createUser(){
    
        let user: UserServiceProtocol
        #if DEBUG
        user = TestUserService()
        #else
        user = CurrentUserService()
        #endif
        
        if let user2 = user.createUser(userName: inputUserName){
            outputUserInfo = user2
        }
    }
    
    func segueToGallery(){
        coordinator?.segueToGallery()
    }
}

