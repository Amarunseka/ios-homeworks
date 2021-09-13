//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//


import UIKit
import StorageService
import iOSIntPackage

class ProfileViewController: UIViewController {
    
    var tableView = UITableView(frame: .zero, style: .plain)
    let cellPostsID = "cellPostsID"
    let cellPhotosID = "cellPhotosID"
    //let filter = ImageProcessor()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if DEBUG
        view.backgroundColor = .systemGray6
        #else
        view.backgroundColor = .green
        #endif
        
        setupTableView()
        setupConstraints()
    }

    
// MARK: - Setups
    
    func setupTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: cellPostsID)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: cellPhotosID)
    }

    
    func setupConstraints(){
        let constraints = [
            
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
    private var crossButton: UIButton?
    

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
            crossButton = UIButton(type: .system)
            crossButton?.setBackgroundImage(UIImage(systemName: "multiply.circle"), for: .normal)
            crossButton?.sizeToFit()
            crossButton?.tintColor = .black
            crossButton?.transform = crossButton!.transform.scaledBy(x: 1.5, y: 1.5)
            crossButton?.alpha = 0
        }
        setupCrossButton()
        
             
        self.view.addSubview(backgroundView ?? UIImageView())
        self.view.addSubview(avatarImageView ?? UIView())
        avatarImageView?.addSubview(crossButton ?? UIButton())
        
        
        self.tabBarController?.tabBar.isHidden = true
    
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1){
                self.avatarImageView?.bounds.size.width = UIScreen.main.bounds.width
                self.avatarImageView?.bounds.size.height = UIScreen.main.bounds.width * heightAvatar
            }
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1){
                self.avatarImageView?.center = CGPoint(
                    x: self.view.bounds.midX,
                    y: self.view.bounds.midY)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1){
                self.avatarImageView?.layer.cornerRadius = 0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1){
                self.backgroundView?.alpha = 0.7
            }
            
        }, completion: {finished in
            UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: [], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2) {
                    if self.avatarImageView != nil && self.crossButton != nil{
                        self.crossButton?.frame.origin = CGPoint(
                            x: self.avatarImageView!.frame.maxX - self.crossButton!.bounds.size.width * 1.5,
                            y: 0)
                    }
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.8) {
                    self.crossButton?.alpha = 1
                }
            })
        })

        
        avatarImageView?.isUserInteractionEnabled = true
        crossButton?.isUserInteractionEnabled = true
        
        crossButton?.addTarget(self, action: #selector(self.reversViewAnimate), for: .touchUpInside)
        self.view.layoutIfNeeded()
    }
    
    
    @objc func reversViewAnimate(){
        self.view.layoutIfNeeded()
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1){
                self.crossButton?.alpha = 0
                self.crossButton = nil
            }

            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1){
                self.backgroundView?.alpha = 0
                self.backgroundView = nil
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1){
                self.avatarImageView?.alpha = 0
                self.avatarImageView?.layer.cornerRadius = self.view.bounds.height / 2
                self.avatarImageView?.frame = CGRect(
                    x: 1,
                    y: 1,
                    width: 1,
                    height: 1)
                self.avatarImageView = nil
                self.tabBarController?.tabBar.isHidden = false
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
            let cell = tableView.dequeueReusableCell(withIdentifier: cellPhotosID) as! PhotosTableViewCell
            return cell
            
        case let n where n > 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellPostsID) as! PostTableViewCell
            cell.post = PostsStorage.posts[indexPath.row-1]
            
//            if let image = UIImage(named: cell.post!.image) {
//                filter.processImage(sourceImage: image, filter: Filters.filters[indexPath.row-1]) {
//                    (image) in cell.postImageView.image = image}}
            return cell
            
        default:
            return UITableViewCell ()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return PostsStorage.posts.count + 1
    }
}

    
    
// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let profileHeader = ProfileHeaderView()
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
            let photoViewController = PhotosViewController()
            navigationController?.pushViewController(photoViewController, animated: true)}

        tableView.deselectRow(at: indexPath, animated: false)
    }
}





