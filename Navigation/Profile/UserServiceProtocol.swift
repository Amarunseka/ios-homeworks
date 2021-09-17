//
//  UserServiceProtocol.swift
//  Navigation
//
//  Created by Миша on 17.09.2021.
//

import Foundation
import UIKit

protocol UserServiceProtocol {
    func createUser(userName: String) -> User?
}
