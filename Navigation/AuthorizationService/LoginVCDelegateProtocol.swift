//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Миша on 20.09.2021.
//

import Foundation

protocol LoginViewControllerDelegateProtocol: AnyObject {
    
    func checkUserAuthentication(email: String, password:String, completion: @escaping (Bool)->Void)
}
