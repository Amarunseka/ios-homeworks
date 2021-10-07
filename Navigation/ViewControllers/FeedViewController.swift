//
//  FeedViewController.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {

    var postInfo = TitlePostPage(title: "Breaking news")
    var stackView = UIStackView()
    
    let buttonToPostFirst = UIButton(type: .system)
    let buttonToPostSecond = UIButton(type: .system)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feed"
        view.backgroundColor = .customColorBlue
        
        createButton(button: buttonToPostFirst, title: "THE POST", color: .systemGreen)
        createButton(button: buttonToPostSecond, title: "THE POST\n(again)", color: .systemTeal)

        configureStackView()
        setStackViewConstrains()
    }

    
    
    func configureStackView(){
        buttonToPostFirst.heightAnchor.constraint(equalToConstant: 70).isActive = true
        buttonToPostFirst.widthAnchor.constraint(equalToConstant: 150).isActive = true

        self.view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.addArrangedSubview(buttonToPostFirst)
        stackView.addArrangedSubview(buttonToPostSecond)
    }
    
    
    func setStackViewConstrains(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
}




// MARK: - extension CreateButton

extension FeedViewController {
    
    func createButton(button: UIButton, title: String, color: UIColor){
        
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        button.showsTouchWhenHighlighted = true
        button.sizeToFit()
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(performDisplaySecondVC(parameterSender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
    }
    
    @objc func performDisplaySecondVC(parameterSender: Any) {
        let postVC = PostViewController()
        self.navigationController?.pushViewController(postVC, animated: true)
    }
}
