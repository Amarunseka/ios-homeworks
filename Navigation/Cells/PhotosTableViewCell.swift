//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//

import UIKit
import StorageService

class PhotosTableViewCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.sizeToFit()
        return label
    }()

    private let arrowButton: CustomButton = {
        let button = CustomButton(
            backgroundImage: UIImage(systemName: "arrow.right"),
            autoLayout: .yes)
        button.tintColor = .black
        return button
    }()
    
    
    private var firstPhotoImageView = UIImageView()
    private var secondPhotoImageView = UIImageView()
    private var thirdPhotoImageView = UIImageView()
    private var fourthPhotoImageView = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemGray6
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowButton)
        
        firstPhotoImageView = createImage(0)
        secondPhotoImageView = createImage(1)
        thirdPhotoImageView = createImage(2)
        fourthPhotoImageView = createImage(3)
        
        setupViewConstraints()
    }

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupViewConstraints() {
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let sideAnchor: CGFloat = 12
        let betweenAnchor: CGFloat = 8
        
        let widthAndHeight: CGFloat = (contentView.bounds.size.width - ((sideAnchor * 2) + (betweenAnchor * 3))) / 3
        
        let constraints = [
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: sideAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideAnchor),

            
            arrowButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            arrowButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -sideAnchor),
            
            
            firstPhotoImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: sideAnchor),
            firstPhotoImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            firstPhotoImageView.widthAnchor.constraint(equalToConstant: widthAndHeight),
            firstPhotoImageView.heightAnchor.constraint(equalTo: firstPhotoImageView.widthAnchor),
            firstPhotoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            
            secondPhotoImageView.topAnchor.constraint(equalTo: firstPhotoImageView.topAnchor),
            secondPhotoImageView.leadingAnchor.constraint(equalTo: firstPhotoImageView.trailingAnchor, constant: betweenAnchor),
            secondPhotoImageView.bottomAnchor.constraint(equalTo: firstPhotoImageView.bottomAnchor),
            secondPhotoImageView.widthAnchor.constraint(equalTo: firstPhotoImageView.widthAnchor),
            secondPhotoImageView.heightAnchor.constraint(equalTo: firstPhotoImageView.widthAnchor),

            
            thirdPhotoImageView.topAnchor.constraint(equalTo: firstPhotoImageView.topAnchor),
            thirdPhotoImageView.leadingAnchor.constraint(equalTo: secondPhotoImageView.trailingAnchor, constant: betweenAnchor),
            thirdPhotoImageView.bottomAnchor.constraint(equalTo: firstPhotoImageView.bottomAnchor),
            thirdPhotoImageView.widthAnchor.constraint(equalTo: firstPhotoImageView.widthAnchor),
            thirdPhotoImageView.heightAnchor.constraint(equalTo: firstPhotoImageView.heightAnchor),

            
            fourthPhotoImageView.topAnchor.constraint(equalTo: firstPhotoImageView.topAnchor),
            fourthPhotoImageView.leadingAnchor.constraint(equalTo: thirdPhotoImageView.trailingAnchor, constant: betweenAnchor),
            fourthPhotoImageView.bottomAnchor.constraint(equalTo: firstPhotoImageView.bottomAnchor),
            fourthPhotoImageView.widthAnchor.constraint(equalTo: firstPhotoImageView.widthAnchor),
            fourthPhotoImageView.heightAnchor.constraint(equalTo: firstPhotoImageView.heightAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}


// MARK: - createPhotoImage
extension PhotosTableViewCell {
    
    private func createImage(_ index: Int) -> UIImageView {
        
        let view = UIImageView()
        view.image = PhotosImage.photos[index]
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        self.contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

