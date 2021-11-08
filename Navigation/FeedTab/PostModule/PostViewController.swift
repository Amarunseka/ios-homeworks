//
//  PostViewController.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//

import UIKit

class PostViewController: UIViewController {
    
    let viewModel: PostViewModel
 
    private let titleFromFeedViewController = FeedViewModel(checkerText: nil)
    
    init(model:PostViewModel){
        self.viewModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.coordinator?.childDidFinish(viewModel.coordinator)
    }
    
        
    private func setupView(){
        self.view.backgroundColor = UIColor.lightGray
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .compose,
            target: self,
            action: #selector(presentToInfoViewController(parameter:)))
        self.title = titleFromFeedViewController.postInfo.title
    }
    
    
    @objc private func presentToInfoViewController(parameter: Any) {
        viewModel.presentToInfo()
    }
}


