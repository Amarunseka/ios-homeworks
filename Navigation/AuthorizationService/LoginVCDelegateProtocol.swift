//
//  LoginVCDelegateProtocol.swift
//  Navigation
//
//  Created by Миша on 21.09.2021.
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    
    func checkUserAuthentication(login: String, password:String) -> Bool
}
