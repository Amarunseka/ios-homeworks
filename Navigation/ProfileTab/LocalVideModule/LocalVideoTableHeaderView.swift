//
//  LocalVideoTableHeaderView.swift
//  Navigation
//
//  Created by Миша on 20.01.2022.
//

import UIKit

class LocalVideoTableHeaderView: UIView {
    
    let image = UIImageView()
    
    init(){
        super.init(frame: .zero)
        setupView()
        setupImageView()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.frame.size = CGSize(
            width: UIScreen.main.bounds.width,
            height: 180)
    }
    
    func setupImageView(){
        self.addSubview(image)
        image.image = UIImage(named: "localVideo")
        image.frame = self.bounds
        image.alpha = 0.7
    }
}
