//
//  LoginVCDelegateProtocol.swift
//  Navigation
//
//  Created by Миша on 21.09.2021.
//

import Foundation

protocol LoginViewControllerDelegateProtocol: AnyObject {
    
    func checkUserAuthentication(login: String, password:String) -> Bool
}
