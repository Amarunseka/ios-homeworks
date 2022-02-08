//
//  SlideMenuContainerVC.swift
//  Navigation
//
//  Created by Миша on 21.12.2021.
//

import UIKit


class SlideMenuContainerViewController: UIViewController {
   
    private let menuVC: SlideMenuViewController
    private var menuIsCreated = false
    private var menuIsOpen = false
    
    let profileVC: ProfileViewController
    lazy var audioVC = AudioViewController(toggleMenu: toggleMenu, viewModel: AudioViewModel())
    lazy var videoVC = VideoViewController(toggleMenu: toggleMenu)
    lazy var localVideoVC = LocalVideoViewController(toggleMenu: toggleMenu)
    private var currentVC: UIViewController?

    init(menuVC: SlideMenuViewController, profileVC: ProfileViewController) {
        self.menuVC = menuVC
        self.profileVC = profileVC
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfileVC()
    }
    
    private func setupProfileVC() {
        profileVC.delegate = self
        addChild(profileVC)
        view.addSubview(profileVC.view)
        profileVC.didMove(toParent: self)
    }
    
    
    private func setupMenuVC() {
        if !menuIsCreated {
            menuVC.delegate = self
            addChild(menuVC)
            menuVC.didMove(toParent: self)
            view.insertSubview(menuVC.view, at: 0)
            menuIsCreated = true
        }
    }
    
    
    private func showMenuVC() {
        toggleMenu(completion: nil)
    }
    
    private func toggleMenu(completion: (() -> Void)?) {
        if !menuIsOpen {
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0,
                options: .curveEaseInOut) {
                    self.tabBarController?.tabBar.isHidden = true
                    self.profileVC.view.frame.origin.x = self.profileVC.view.frame.width - 140
                } completion: { [weak self] (finished) in
                    self?.menuIsOpen = true
                }

        } else {
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0,
                options: .curveEaseInOut) {
                    self.tabBarController?.tabBar.isHidden = false
                    self.profileVC.view.frame.origin.x = 0
                } completion: { [weak self] (finished) in
                    self?.menuIsOpen = false
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
        }
    }
}



// MARK: - Delegate

extension SlideMenuContainerViewController: ProfileViewControllerDelegate {
    func toggleMenu() {
        setupMenuVC()
        showMenuVC()
    }
}


extension SlideMenuContainerViewController: SlideMenuViewControllerDelegate {
    func didSelect(menuItem: SlideMenuModel) {
        toggleMenu(completion: nil)
        
        switch menuItem {
        case .profile:
            self.resetToProfile()
        case .audio:
            self.addAudioVC()
        case .video:
            self.addVideoVC()
        case .localVideo:
            self.addLocalVideoVC()
            
        }
    }
    
    private func addAudioVC() {
        currentVC?.view.removeFromSuperview()
        currentVC?.didMove(toParent: nil)
        let vc = audioVC
        profileVC.addChild(vc)
        profileVC.view.addSubview(vc.view)
        vc.view.frame = view.bounds
        vc.didMove(toParent: profileVC)
        currentVC = vc
    }
    
    private func addVideoVC() {
        currentVC?.view.removeFromSuperview()
        currentVC?.didMove(toParent: nil)
        let vc = videoVC
        profileVC.addChild(vc)
        profileVC.view.addSubview(vc.view)
        vc.view.frame = view.bounds
        vc.didMove(toParent: profileVC)
        currentVC = vc
    }
    
    
    private func addLocalVideoVC() {
        currentVC?.view.removeFromSuperview()
        currentVC?.didMove(toParent: nil)
        let vc = localVideoVC
        profileVC.addChild(vc)
        profileVC.view.addSubview(vc.view)
        vc.view.frame = view.bounds
        vc.didMove(toParent: profileVC)
        currentVC = vc
    }
    
    
    private func resetToProfile() {
        currentVC?.view.removeFromSuperview()
        currentVC?.didMove(toParent: nil)
        currentVC = nil
    }
}
