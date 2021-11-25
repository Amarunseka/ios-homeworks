//
//  UITabBarItem.swift
//  Navigation
//
//  Created by Миша on 19.10.2021.
//

import UIKit

extension UITabBarItem {
    
    static func createCustomItem(title: String, image: String) -> UITabBarItem {
        guard let image = UIImage(named: image) else {return UITabBarItem()}
        
        let item = UITabBarItem(
            title: title,
            image: image.withRenderingMode(.alwaysTemplate),
            selectedImage: image.withRenderingMode(.alwaysOriginal)
        )
        return item
    }
}
