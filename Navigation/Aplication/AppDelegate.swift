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
    let url = URL(string: AppConfiguration.first.rawValue)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = MainTabBarController()
        
        UITabBar.appearance().backgroundColor = .customColorGray
        setupNB()
        
        // реализация варианта 1
        /// NetworkService.receivePost(url: url)

        // реализация варианта 2
        NetworkService.receiveShipInfo(url: url) { result in
            switch result {
            case .success(let shipInfo):
                guard let shipInfo = shipInfo else {return}
                print(shipInfo)
                // так же можно каждую по отдельности
                print("\nShip's Name: \(shipInfo.Name)")

                
            case .failure(let error):
                print(error.localizedDescription)
                // (error code: -1009 [1:50])
            }
        }
        
        return true
    }
    
    
    func setupNB(){
        appearanceNB.configureWithOpaqueBackground()
        appearanceNB.backgroundColor = .customColorGray
        UINavigationBar.appearance().scrollEdgeAppearance = appearanceNB
    }
    
}

