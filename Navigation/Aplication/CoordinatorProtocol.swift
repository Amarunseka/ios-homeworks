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
    func childDidFinish(_ child: Coordinator?)
    
    func start()
}


extension Coordinator {
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
