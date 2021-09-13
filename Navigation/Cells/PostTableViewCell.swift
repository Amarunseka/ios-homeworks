//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//

import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {
    
    var post: Post? {
        didSet {
            titleLabel.text = post?.title
            postImageView.image = UIImage(named: post?.image ?? "")
            descriptionLabel.text = post?.description
            authorLabel.text = "Author: \(post?.author ?? "")"
            likesLabel.text = "Likes: \(post?.likes ?? 0)"
            viewsLabel.text = "Views: \(post?.views ?? 0)"
            }
        }

    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        label.sizeToFit()
        return label
    }()
    
    var postImageView: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        return image
    }()


    var descriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()

    
    var authorLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    var likesLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()

    var viewsLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .right
        return label
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
}

// MARK: - Setup Post View
private extension PostTableViewCell {

    func setupViews(){
        contentView.backgroundColor = .systemGray6
        contentView.addSubview(titleLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
        
        setupViewConstraints()
    }
    
    func setupViewConstraints(){

        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        descriptionLabel.setContentHuggingPriority(.required, for: .vertical)
        authorLabel.setContentHuggingPriority(.required, for: .vertical)
        likesLabel.setContentHuggingPriority(.required, for: .vertical)
        viewsLabel.setContentHuggingPriority(.required, for: .vertical)


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
