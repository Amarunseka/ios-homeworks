//
//  CoreDataCoordinatorManager.swift
//  Navigation
//
//  Created by Миша on 27.07.2022.
//

import Foundation

final class CoreDataCoordinatorManager {
    
    static let shared = CoreDataCoordinatorManager()
    let coreDataCoordinator: CoreDataCoordinator
    
    private init(){
        self.coreDataCoordinator = Self.setCoreDataCoordinator()
    }
    
    private static func setCoreDataCoordinator() -> CoreDataCoordinator {
        switch CoreDataCoordinator.create() {
        case .success(let coordinator):
            return coordinator
        case .failure(let error):
            fatalError("\(error.localizedDescription)")
        }
    }
}
