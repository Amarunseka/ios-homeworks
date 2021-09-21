//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    var photoImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(photoImage)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        photoImage.contentMode = .scaleAspectFill
        photoImage.clipsToBounds = true
        photoImage.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

