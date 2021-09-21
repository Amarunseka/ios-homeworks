//
//  PostViewController.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//

import UIKit

class PostViewController: UIViewController {
 
    private let titleFromFeedViewController = FeedViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
        
    private func setupView(){
        self.view.backgroundColor = UIColor.lightGray
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(presentToInfoViewController(parameter:)))
        self.title = titleFromFeedViewController.postInfo.title
    }
    
    
    @objc private func presentToInfoViewController(parameter: Any) {
        let infoVC = InfoViewController(nibName: nil, bundle: nil)
        present(infoVC, animated: true, completion: nil)
    }
}

