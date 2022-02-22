//
//  AppDelegate.swift
//  Navigation
//
//  Created by Миша on 02.09.2021.
//

import UIKit
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let appearanceNB = UINavigationBarAppearance()
    let appearanceTB = UITabBarAppearance()
    let url = URL(string: AppConfiguration.first.rawValue)
    private let planetURL = URL(string: "https://swapi.dev/api/planets/1")


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = MainTabBarController()
        
        UITabBar.appearance().backgroundColor = .customColorGray

//        PlanetNetworkService.receivePlanetInfo(url: planetURL) { result in
//            switch result {
//            case .success(let objectInfo):
//                if let info = objectInfo as? Planet {
//                    print(info.residents.count)
//                    for inhabitant in info.residents {
//                        print(inhabitant)
//                    }
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        
        return true
    }

    
    func setupNB(){
        appearanceNB.configureWithOpaqueBackground()
        appearanceNB.backgroundColor = .customColorGray
        UINavigationBar.appearance().scrollEdgeAppearance = appearanceNB
    }
    
}

