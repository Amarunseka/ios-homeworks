//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//


import UIKit
import StorageService

protocol ProfileViewControllerDelegate: AnyObject {
    func toggleMenu()
}

class ProfileViewController: UIViewController {
    
    var viewModel: ProfileViewModel
    weak var delegate: ProfileViewControllerDelegate?
    private let tableView = UITableView(frame: .zero, style: .plain)
    let profileHeader = ProfileHeaderView()
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    var timer = Timer()
    
    
    private lazy var menuButton: UIButton = {
        let button = CustomButton(
            titleColor: .black,
            backgroundImage: UIImage(systemName: "list.dash"),
            highlighted: .yes) { [weak self] in
                self?.delegate?.toggleMenu()
            }
        button.tintColor = .customColorBlue
        return button
    }()

    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupActivityIndicator()
        
        DispatchQueue.main.async { [self] in
        #if DEBUG
        view.backgroundColor = .systemGray6
        #else
        view.backgroundColor = .green
        #endif
            
            setupTableView()
            setupConstraints()
            activityIndicator.stopAnimating()
            showAlert()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.coordinator?.childDidFinish(viewModel.coordinator)
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer()
    }


    
// MARK: - Setups
    
    private func setupTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(
            PhotosTableViewCell.self,
            forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: String(describing: PostTableViewCell.self))
    }
    
    
    private func setupActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
    }
    
    private func showAlert(){
        guard let alert = viewModel.outputAlert else {return}
        present(alert, animated: true)
    }

    
    private func setupConstraints(){
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menuButton)
        let constraints = [
            menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            menuButton.heightAnchor.constraint(equalToConstant: 30),
            menuButton.widthAnchor.constraint(equalToConstant: 30),

            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
// MARK: - Animation

    private var avatarImageView: UIImageView?
    private var backgroundView:  UIView?
    private var crossButton: CustomButton?
    

    @objc func avatarResize(sender: UITapGestureRecognizer) {
        
        self.view.layoutIfNeeded()
        
        func setupAvatarImageView(){
            let imageView = sender.view as! UIImageView
            avatarImageView = UIImageView(image: imageView.image)
            avatarImageView?.layer.cornerRadius = view.bounds.height / 2
            avatarImageView?.contentMode = .scaleAspectFit
            avatarImageView?.clipsToBounds = true
        }
        setupAvatarImageView()
        
        
        var heightAvatar: CGFloat = 0
        if avatarImageView != nil {
            heightAvatar = avatarImageView!.bounds.size.height / avatarImageView!.bounds.size.width
        }
       
  
        func setupBackgroundView() {
            backgroundView = UIView(frame: UIScreen.main.bounds)
            backgroundView?.backgroundColor = UIColor.black
            backgroundView?.alpha = 0
        }
        setupBackgroundView()
        
        
        func setupCrossButton(){
            crossButton = CustomButton(
                backgroundColor: .clear,
                backgroundImage: UIImage(systemName: "multiply.circle")) {
                    [self] in
                    self.reversViewAnimate()}
            crossButton?.sizeToFit()
            crossButton?.tintColor = .black
            crossButton?.transform = crossButton!.transform.scaledBy(x: 1.5, y: 1.5)
            crossButton?.alpha = 0
            crossButton?.isUserInteractionEnabled = true
        }
        setupCrossButton()
        
             
        self.view.addSubview(backgroundView ?? UIImageView())
        self.view.addSubview(avatarImageView ?? UIView())
        avatarImageView?.addSubview(crossButton ?? UIButton())
        
        
        self.tabBarController?.tabBar.isHidden = true
    
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: { [self] in
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1){ [self] in
                avatarImageView?.bounds.size.width = UIScreen.main.bounds.width
                avatarImageView?.bounds.size.height = UIScreen.main.bounds.width * heightAvatar
                avatarImageView?.center = CGPoint(
                    x: view.bounds.midX,
                    y: view.bounds.midY)
                avatarImageView?.layer.cornerRadius = 0
                backgroundView?.alpha = 0.7
            }
            
        }, completion: {finished in
            UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: [], animations: { [self] in
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2) { [self] in
                    if avatarImageView != nil && crossButton != nil{
                        crossButton?.frame.origin = CGPoint(
                            x: avatarImageView!.frame.maxX - crossButton!.bounds.size.width * 1.5,
                            y: 0)
                    }
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.8) { [self] in
                    crossButton?.alpha = 1
                }
            })
        })

        avatarImageView?.isUserInteractionEnabled = true
        
        self.view.layoutIfNeeded()
    }
    
    
    @objc func reversViewAnimate(){
        self.view.layoutIfNeeded()
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: { [self] in
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1){ [self] in
                crossButton?.alpha = 0
                crossButton = nil
                backgroundView?.alpha = 0
                backgroundView = nil
                avatarImageView?.alpha = 0
                avatarImageView?.layer.cornerRadius = view.bounds.height / 2
                avatarImageView?.frame = CGRect(
                    x: 1,
                    y: 1,
                    width: 1,
                    height: 1)
                avatarImageView = nil
                tabBarController?.tabBar.isHidden = false
            }
        })
        self.view.layoutIfNeeded()
    }
}
    

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: PhotosTableViewCell.self)) as! PhotosTableViewCell
            return cell
            
        case let n where n > 0:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: PostTableViewCell.self)) as! PostTableViewCell
            cell.post = PostsStorage.posts[indexPath.row-1]
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return PostsStorage.posts.count + 1
    }
}
    
    
// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        profileHeader.fullNameLabel.text = viewModel.outputUserInfo?.userName
        profileHeader.avatarImageView.image = viewModel.outputUserInfo?.userAvatar
        profileHeader.statusLabel.text = viewModel.outputUserInfo?.userStatus
                
        profileHeader.avatarImageView.isUserInteractionEnabled = true
        profileHeader.avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(avatarResize)))
        profileHeader.backgroundColor = .systemGray6

        return profileHeader
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 200
    }
    
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if indexPath.row == 0 {
            viewModel.segueToGallery()
        }

        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - Timer
extension ProfileViewController {
    func startTimer(){
        var time = 10
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true,
            block: { [weak self] _ in
                if time > 0 {
                    time -= 1
                } else if time == 0 {
                    self?.tableView.reloadData()
                    sleep(1)
                    time = 10
                }
                if time != 0 {
                    self?.profileHeader.timerUntilReload.text = "Time until reload:\n \(time)"
                } else {
                    self?.profileHeader.timerUntilReload.text = "RELOAD DATA"
                }
            })
        RunLoop.current.add(timer, forMode: .common)
    }
    
    func stopTimer(){
        timer.invalidate()
        self.profileHeader.timerUntilReload.text = "RELOAD DATA"
    }
}
