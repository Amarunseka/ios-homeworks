//
//  UIVC.swift
//  Navigation
//
//  Created by Миша on 21.10.2021.
//

import UIKit

extension UIViewController {
    
    func createButton(title: String, fontSize: CGFloat, color: UIColor, action: @escaping ()->Void) -> CustomButton {
        
        let button = CustomButton(
            title: title,
            backgroundColor: color,
            fontSize: fontSize,
            fontWeight: .regular,
            textAlignment: .center,
            highlighted: .yes,
            lineBreak: .byWordWrapping,
            buttonAction: action)
        
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        
        return button
    }
}
