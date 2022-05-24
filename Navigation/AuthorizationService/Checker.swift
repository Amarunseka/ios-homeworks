//
//  Checker.swift
//  Navigation
//
//  Created by Миша on 20.09.2021.
//

import Foundation
import Firebase

class Checker {
    
    static let shared: Checker = .init()
    
    private let authorizationUserInfo: [String: String]

    
    private init(){
        #if DEBUG
        self.authorizationUserInfo = ["Amarunseka@gmail.com": "22"]
        #else
        self.authorizationUserInfo = ["Test@gmail.com": "22"]
        #endif
    }
     
    
    func checkAuthentication(email:String, password: String, completion: @escaping (Bool)->Void){
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) {result, error in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}
