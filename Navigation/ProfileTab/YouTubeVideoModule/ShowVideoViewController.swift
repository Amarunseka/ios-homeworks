//
//  VideoViewController.swift
//  Navigation
//
//  Created by Миша on 23.12.2021.
//

import UIKit

class ShowVideoViewController: UIViewController {

    private var youtubeView = YoutubePlayerView(videoURL: "")
    private let video: Video
    private let backgroundView = UIView()
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    private let nameVideoLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let goBackButton = UIButton()
    
    init(video: Video) {
        self.video = video
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - очень долго возился, но так и не смог сделать navigationBar прозрачным, при всех манипуляциях background ни как не делался за ним, поэтому сделал просто кнопку back
//        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "beton") ?? UIImage())
        
        setupScrollView()
        setupContainerView()
        setupNameVideoLabel()
        setupYoutubeView()
        setupDescriptionLabel()
        setupGoBackButton()

        setupConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    private func setupScrollView(){
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupContainerView(){
        scrollView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupYoutubeView(){
        self.youtubeView = YoutubePlayerView(videoURL: video.url)
        youtubeView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(youtubeView)
    }
    
    private func setupNameVideoLabel(){
        nameVideoLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(nameVideoLabel)
        nameVideoLabel.text = video.name
        nameVideoLabel.textColor = .white
        nameVideoLabel.textAlignment = .center
        nameVideoLabel.numberOfLines = 1
        nameVideoLabel.font = UIFont.systemFont(ofSize: 26, weight: .heavy)
        nameVideoLabel.sizeToFit()
        nameVideoLabel.backgroundColor = .clear
    }
    
    
    private func setupDescriptionLabel(){
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(descriptionLabel)
        descriptionLabel.text = video.description
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .justified
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        descriptionLabel.sizeToFit()
        descriptionLabel.backgroundColor = .clear
    }
    
    private func setupGoBackButton(){
        goBackButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(goBackButton)
        goBackButton.setTitle("Back", for: .normal)
        goBackButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        goBackButton.setTitleColor(.black, for: .normal)
        goBackButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
    
    @objc func goBack(){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    private func setupConstraints(){
        let constraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            goBackButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            goBackButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            
            nameVideoLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            nameVideoLabel.topAnchor.constraint(equalTo: goBackButton.bottomAnchor, constant: 10),
            nameVideoLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            
            youtubeView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            youtubeView.topAnchor.constraint(equalTo: nameVideoLabel.bottomAnchor, constant: 15),
            youtubeView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            youtubeView.heightAnchor.constraint(equalToConstant: 280),

            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            descriptionLabel.topAnchor.constraint(equalTo: youtubeView.bottomAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
 
}
