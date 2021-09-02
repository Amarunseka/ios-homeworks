//
//  PostViewController.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//

import UIKit

class PostViewController: UIViewController {
 
    let titleFromFeedViewController = FeedViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
        
    func setupView(){
        self.view.backgroundColor = UIColor.lightGray
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(presentToInfoViewController(parameter:)))
        self.title = titleFromFeedViewController.postInfo.title
    }
    
    
    @objc func presentToInfoViewController(parameter: Any) {
        let infoVC = InfoViewController(nibName: nil, bundle: nil)
        present(infoVC, animated: true, completion: nil)
    }
}
