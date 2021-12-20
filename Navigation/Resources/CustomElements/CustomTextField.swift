//
//  CustomTextField.swift
//  Navigation
//
//  Created by Миша on 29.09.2021.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    enum ChoiceParameter {
        case yes, no
    }
    
    init(backgroundColor: UIColor = .white,
         textColor: UIColor = .black,
         tintColor: UIColor = .black,
         fontSize: CGFloat = 0,
         fontWeight: UIFont.Weight = .regular,
         borderStyle: UITextField.BorderStyle = .roundedRect,
         textAlignment: NSTextAlignment = .left,
         placeholder: String? = nil,
         autocapitalizationType: UITextAutocapitalizationType = .none,
         isSecureTextEntry: ChoiceParameter = .no,
         autoLayout: ChoiceParameter = .no
    ){
        super.init(frame: .zero)

        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.tintColor = tintColor
        self.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        self.borderStyle = borderStyle
        self.textAlignment = textAlignment

        self.placeholder = placeholder
        self.autocapitalizationType = autocapitalizationType
        if isSecureTextEntry == .yes {self.isSecureTextEntry = true}
        if autoLayout == .yes {self.translatesAutoresizingMaskIntoConstraints = false}
        
        self.returnKeyType = UIReturnKeyType.done
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
