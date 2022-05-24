//
//  CustomButton.swift
//  Navigation
//
//  Created by Миша on 28.09.2021.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    private var buttonAction: (()->())!
    
    enum ChoiceParameter {
        case yes, no
    }
   
    convenience init(
        type: UIButton.ButtonType = .system,
        title: String? = nil,
        titleColor: UIColor = .white,
        backgroundColor: UIColor = .clear,
        backgroundImage: UIImage? = nil,
        fontSize: CGFloat = 0,
        fontWeight: UIFont.Weight = .regular,
        textAlignment: NSTextAlignment = .center,
        highlighted: ChoiceParameter = .no,
        lineBreak: NSLineBreakMode = .byTruncatingTail,
        buttonAction: @escaping (()-> ())
    ) {
        self.init(type: type)
        self.buttonAction = buttonAction
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        if (backgroundImage != nil) {self.setBackgroundImage(backgroundImage, for: .normal)}
        self.titleLabel?.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        self.titleLabel?.textAlignment = textAlignment


        if highlighted == .yes {
            self.showsTouchWhenHighlighted = true
        }

        self.titleLabel?.lineBreakMode = lineBreak
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc
    private func buttonTapped() {
        self.buttonAction()
    }
}
