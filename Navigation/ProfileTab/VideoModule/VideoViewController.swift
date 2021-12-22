//
//  VideoViewController.swift
//  Navigation
//
//  Created by Миша on 22.12.2021.
//

import UIKit

class VideoViewController: UIViewController {

    private let toggleMenu: (() -> Void)
    
    init(toggleMenu: @escaping (() -> Void)){
        self.toggleMenu = toggleMenu
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var menuButton: UIButton = {
        let button = CustomButton(
            titleColor: .black,
            backgroundImage: UIImage(systemName: "list.dash"),
            highlighted: .yes) { [weak self] in
                self?.toggleMenu()
            }
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Video Player"
        view.backgroundColor = .systemRed
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    private func setupConstraints(){
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menuButton)
        let constraints = [
            menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            menuButton.heightAnchor.constraint(equalToConstant: 30),
            menuButton.widthAnchor.constraint(equalToConstant: 30),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

}
