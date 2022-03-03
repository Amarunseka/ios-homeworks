//
//  SlideMenuTableViewCell.swift
//  Navigation
//
//  Created by Миша on 21.12.2021.
//

import UIKit

class SlideMenuTableViewCell: UITableViewCell {
    
    static let reuseId = "MenuTableCell"
    
    let iconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        return image
    }()
    
    let myLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Custom text"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(iconImageView)
        addSubview(myLabel)
        backgroundColor = .clear
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupConstraints(){
        
        let constraints = [
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            
            
            myLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            myLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
