//
//  Checker.swift
//  Navigation
//
//  Created by Миша on 20.09.2021.
//

import Foundation

class Checker {
    
    static let shared: Checker = .init()
    
    private let authorizationUserInfo: [String: String]

    
    private init(){
        #if DEBUG
        self.authorizationUserInfo = ["A": "22"]
        #else
        self.authorizationUserInfo = ["Test": "22"]
        #endif
    }
     
    
    func checkAuthentication(login:String, password: String) -> Bool{
        
        return authorizationUserInfo[login] == password
    }
}
