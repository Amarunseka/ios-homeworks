//
//  AppDelegate.swift
//  Navigation
//
//  Created by Миша on 02.09.2021.
//

import UIKit
import AVFoundation
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coreDataCoordinator: CoreDataCoordinator?

    let appearanceNB = UINavigationBarAppearance()
    let appearanceTB = UITabBarAppearance()
  
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        coreDataCoordinator = setCoreDataCoordinator()
        
        appearanceNB.configureWithDefaultBackground()
        appearanceTB.configureWithDefaultBackground()
        UINavigationBar.appearance().scrollEdgeAppearance = appearanceNB
        UITabBar.appearance().scrollEdgeAppearance = appearanceTB

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        guard let coreDataCoordinator = coreDataCoordinator else {return true}
        window?.rootViewController = MainTabBarController(coreDataCoordinator: coreDataCoordinator)
        return true
    }
    
    
    private func setCoreDataCoordinator() ->CoreDataCoordinator {
        var coreDataCoordinator: CoreDataCoordinator {
            switch CoreDataCoordinator.create() {
            case .success(let coordinator):
                return coordinator
            case .failure(let error):
                fatalError("\(error.localizedDescription)")
            }
        }
        return coreDataCoordinator
    }
}

