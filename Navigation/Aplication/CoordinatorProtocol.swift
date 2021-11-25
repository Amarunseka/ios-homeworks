//
//  CoordinatorProtocol.swift
//  Navigation
//
//  Created by Миша on 19.10.2021.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
