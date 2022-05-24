//
//  ErrorAlert.swift
//  Navigation
//
//  Created by Миша on 03.12.2021.
//

import UIKit

class ShowAlert: VideoViewController {
    
    class func showAlert(_ text: String) -> UIAlertController{
        let alertController = UIAlertController(
            title: "Ошибка!",
            message: text,
            preferredStyle: .alert)
        
        
        let okAction = UIAlertAction(title: "ОK", style: .default)
        
        alertController.view.tintColor = .customColorBlue
        alertController.addAction(okAction)
        
        
        if let title = alertController.title, let message = alertController.message {
            alertController.setValue(NSAttributedString(
                string: title,
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular),
                             NSAttributedString.Key.foregroundColor: UIColor.accentColor ?? .black]),
                                     forKey: "attributedTitle")
            
            alertController.setValue(NSAttributedString(
                string: message,
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15,weight: UIFont.Weight.regular),
                             NSAttributedString.Key.foregroundColor: UIColor.red]),
                                     forKey: "attributedMessage")
        }
        
        return alertController
    }
}
