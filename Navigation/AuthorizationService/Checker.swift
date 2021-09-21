//
//  Checker.swift
//  Navigation
//
//  Created by Миша on 21.09.2021.
//

import Foundation

class Checker {
    
    static let data: Checker = .init()
    
    private let authorizationUserInfo: [String: String]

    
    private init(){
        #if DEBUG
        self.authorizationUserInfo = ["Test": "22"]
        #else
        self.authorizationUserInfo = ["Amarunseka": "22"]
        #endif
    }
     
    
    func checkAuthentication(login:String, password: String) -> Bool{
        
        if authorizationUserInfo[login] == password {
            return true
        } else {
            return false
        }
    }
}
