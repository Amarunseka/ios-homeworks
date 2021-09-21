//
//  PhotoViewController.swift
//
//
//  Created by Миша on 15.09.2021.
//

import UIKit
import SnapKit

class PhotoViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
      

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }

    
    private func setupView() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(imageView)
    }

    
    private func setupConstraints(){
        
        scrollView.snp.makeConstraints{make in
            make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        
        containerView.snp.makeConstraints{make in
            make.top.bottom.leading.trailing.width.equalTo(scrollView)
        }

        
        imageView.snp.makeConstraints{make in
            make.top.centerX.width.bottom.equalTo(containerView)
            make.height.equalTo(UIScreen.main.bounds.height)
        }
    }
}
