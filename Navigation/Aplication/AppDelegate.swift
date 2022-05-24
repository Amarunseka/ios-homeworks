//
//  AppDelegate.swift
//  Navigation
//
//  Created by Миша on 02.09.2021.
//
//

import UIKit
import AVFoundation
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let appearanceNB = UINavigationBarAppearance()
    let appearanceTB = UITabBarAppearance()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        appearanceNB.configureWithDefaultBackground()
        appearanceTB.configureWithDefaultBackground()
        UINavigationBar.appearance().scrollEdgeAppearance = appearanceNB
        UITabBar.appearance().scrollEdgeAppearance = appearanceTB

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = MainTabBarController()
        
//        UITabBar.appearance().backgroundColor = .customColorGray

        return true
    }
//
//
//    func setupNB(){
//        appearanceNB.configureWithOpaqueBackground()
//        appearanceNB.backgroundColor = .customColorGray
//        UINavigationBar.appearance().scrollEdgeAppearance = appearanceNB
//    }
//
}

