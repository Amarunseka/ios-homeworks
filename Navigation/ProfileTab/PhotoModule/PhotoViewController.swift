//
//  PhotoViewController.swift
//
//
//  Created by Миша on 15.09.2021.
//

import UIKit
import SnapKit

class PhotoViewController: UINavigationController {
    
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.alpha = 0.7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var crossCloseWindowButton: CustomButton = {
        let button = CustomButton(
            backgroundColor:.clear,
            backgroundImage: UIImage(systemName: "multiply.circle")) {
                [weak self] in
                self?.dismiss(animated: true)
            }
        button.tintColor = .black
        return button
    }()

    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
      

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        setupView()
        setupConstraints()
    }

    
    private func setupView() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(backgroundView)
        containerView.addSubview(crossCloseWindowButton)
        containerView.addSubview(imageView)
    }

    
    private func setupConstraints(){
        
        scrollView.snp.makeConstraints{make in
            make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        
        containerView.snp.makeConstraints{make in
            make.top.bottom.leading.trailing.width.equalTo(scrollView)
        }
        
        
        backgroundView.snp.makeConstraints{make in
            make.top.centerX.width.height.bottom.equalTo(containerView)
        }
        
        
        crossCloseWindowButton.snp.makeConstraints{make in
            make.top.trailing.equalTo(backgroundView).inset(10)
        }
        
        
        imageView.snp.makeConstraints{make in
            make.top.centerX.width.bottom.equalTo(containerView)
            make.height.equalTo(UIScreen.main.bounds.height)
        }
    }
}
