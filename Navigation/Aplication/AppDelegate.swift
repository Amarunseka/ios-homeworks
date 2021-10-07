//
//  AppDelegate.swift
//  Navigation
//
//  Created by Миша on 02.09.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let appearanceNB = UINavigationBarAppearance()
    let appearanceTB = UITabBarAppearance()
    //let loginInspector = LoginInspector()/

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = MainTabBarController()
        
        UITabBar.appearance().backgroundColor = .customColorGray
        setupNB()
        
//        if let tabController = window?.rootViewController as? MainTabBarController,
//           let loginNavigation = tabController.viewControllers?.last as? UINavigationController,
//           let loginController = loginNavigation.viewControllers.first as? LogInViewController {
//            loginController.delegate = loginInspector
//        }

        return true
    }
    
    
    func setupNB(){
        appearanceNB.configureWithOpaqueBackground()
        appearanceNB.backgroundColor = .customColorGray
        UINavigationBar.appearance().scrollEdgeAppearance = appearanceNB
    }
}

