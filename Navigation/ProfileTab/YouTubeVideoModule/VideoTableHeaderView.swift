//
//  VideoTableHeaderView.swift
//  Navigation
//
//  Created by Миша on 23.12.2021.
//

import UIKit

class VideoTableHeaderView: UIView {
    
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
        image.image = UIImage(named: "header")
        image.frame = self.bounds
    }
}
