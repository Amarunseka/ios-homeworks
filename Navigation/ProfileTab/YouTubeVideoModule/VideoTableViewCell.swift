//
//  VideoTableViewCell.swift
//  Navigation
//
//  Created by Миша on 23.12.2021.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    var video: Video? {
        didSet {
            titleLabel.text = video?.name
            descriptionLabel.text = video?.description
            previewImage.image = UIImage(named: video?.image ?? "")
        }
    }
    
    let titleLabel = UILabel()
    let previewImage = UIImageView()
    let descriptionLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupTitleLabel()
        setupPreviewImage()
        setupDescriptionLabel()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupTitleLabel(){
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 1
        titleLabel.sizeToFit()
    }
    
    func setupPreviewImage(){
        contentView.addSubview(previewImage)
        previewImage.translatesAutoresizingMaskIntoConstraints = false
        previewImage.contentMode = .scaleAspectFit
        previewImage.backgroundColor = .black
    }
    
    func setupDescriptionLabel(){
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.numberOfLines = 5
        descriptionLabel.textAlignment = .justified
        descriptionLabel.sizeToFit()
    }
    
    
    func setupConstraints(){
        let constraints = [
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            
            previewImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            previewImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            previewImage.widthAnchor.constraint(equalToConstant: 100),
            previewImage.heightAnchor.constraint(equalToConstant: 100),
            previewImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            
            descriptionLabel.leadingAnchor.constraint(equalTo: previewImage.trailingAnchor, constant: 10),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
