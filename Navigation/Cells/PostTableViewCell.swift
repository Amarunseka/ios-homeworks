//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//

import UIKit
import StorageService
import iOSIntPackage

class PostTableViewCell: UITableViewCell {

    var post: Post? {
        didSet {
            titleLabel.text = post?.title
            descriptionLabel.text = post?.postDescription
            authorLabel.text = "Author: \(post?.author ?? "")"
            likesLabel.text = "Likes: \(post?.likes ?? 0)"
            viewsLabel.text = "Views: \(post?.views ?? 0)"
            isLiked = post?.isLiked ?? false
            changeIfIsLiked(isLiked: isLiked)

            if let image = UIImage(named: post?.image ?? "face.smiling") {
                filterProcessor.processImage(
                    sourceImage: image,
                    filter: filters.randomElement() ?? .chrome) {
                    (image) in postImageView.image = image
                }
            }
        }
    }
    
    private let filterProcessor = ImageProcessor()
    private let filters: [ColorFilter] = ColorFilter.allCases

    var isLiked = false
    var isLikeButtonTap: ((Post, Bool)->())?

    private var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        label.sizeToFit()
        return label
    }()
    
    private var postImageView: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        return image
    }()


    private var descriptionLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()

    
    private var authorLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private var likesLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()

    private var viewsLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(likeButtonTap), for: .touchUpInside)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupViewConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        contentView.backgroundColor = .systemGray6
        
        [titleLabel, postImageView, descriptionLabel, authorLabel, likesLabel, viewsLabel, likeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        changeIfIsLiked(isLiked: isLiked)
        setupViewConstraints()
    }
    
    @objc
    func likeButtonTap() {
        guard let isLikeButtonTap = isLikeButtonTap,
              let post = post
        else {return}
        isLiked.toggle()
        isLikeButtonTap(post, isLiked)
        changeIfIsLiked(isLiked: isLiked)
    }
    
    private func changeIfIsLiked(isLiked: Bool) {
        var image: UIImage?
        var color: UIColor
        if isLiked {
            image = UIImage(systemName: "heart.circle")
            color = .purple
        }  else {
            image = UIImage(systemName: "heart.circle.fill")
            color = .systemBlue
        }
        likeButton.setImage(image, for: .normal)
        likeButton.tintColor = color
    }
}

// MARK: - set Constraints
private extension PostTableViewCell {

    func setupViewConstraints(){
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            
            
            postImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            postImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor),
            
            
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
            
            
            authorLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            authorLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            authorLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
            
            likeButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            likeButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            
            likesLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10),
            likesLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            likesLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            
            viewsLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10),
            viewsLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            viewsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
