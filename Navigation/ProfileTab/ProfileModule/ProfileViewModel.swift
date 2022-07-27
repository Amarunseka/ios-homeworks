//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Миша on 08.11.2021.
//

import Foundation
import UIKit
import StorageService


class ProfileViewModel {
    
    weak var coordinator: ProfileCoordinator?
    
    var outputUserInfo: User?
    var outputReloadTableView: (()->())?
    var outputAlert: UIAlertController?
    var outputPosts = PostsStorage.posts
    
    private let inputUserName: String
    private let coreDataCoordinator = CoreDataCoordinatorManager.shared.coreDataCoordinator

    init(inputUserName: String){
        self.inputUserName = inputUserName
        
        fetchData()
        
        self.createUser {user in
            switch user {
            case.success(let user):
                self.outputUserInfo = user
            case.failure(let error):
                self.outputAlert = ShowAlert.showAlert(error.localizedDescription)
            }
        }
    }
    
    private func createUser(completion: @escaping (Result<User, AuthenticationErrors>) -> Void) {
    
        var user: UserServiceProtocol
        
        #if DEBUG
        user = CurrentUserService(user: inputUserName)
        #else
        user = TestUserService()
        #endif
        
        if let user = user.createUser(userName: inputUserName) {
            completion(.success(user))
        } else {
            completion(.failure(.userNotFound))
        }
    }
    
    func segueToGallery(){
        coordinator?.segueToGallery()
    }
}

// MARK: - SetupCoreData
extension ProfileViewModel {
    
    private func fetchData(){
        coreDataCoordinator.fetchAll(PostsCoreDataModel.self) { [weak self] result in
            switch result {
            case .success(let models):
                guard let posts = self?.outputPosts, !models.isEmpty else {return}

                for (index, post) in posts.enumerated() {
                    guard let favoritePost = models.first(where: { $0.title == post.title}) else {continue}
                    self?.outputPosts[index].isLiked = favoritePost.isLiked
                }
            case .failure(let error):
                print("Error: \(error)")
            }

            guard let outputReloadTableView = self?.outputReloadTableView else {return}
            outputReloadTableView()
        }
    }
    
    func addToFavoriteGesture() -> UITapGestureRecognizer{
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapAddToFavoriteGesture))
        gesture.numberOfTapsRequired = 2
        return gesture
    }
    
    @objc
    private func tapAddToFavoriteGesture(gesture: UITapGestureRecognizer){
        guard let cell = gesture.view as? PostTableViewCell else {return}
        cell.likeButtonTap()
    }
    
    func addToFavorite(model:Post, isLiked: Bool, index: Int) {
        var post = model

        switch isLiked {
        case true:
            post.isLiked = isLiked
            coreDataCoordinator.create(PostsCoreDataModel.self, keyedValues: [post.keyValues]) { [weak self] result in
                self?.outputPosts[index].isLiked = true
            }
            let userInfo = ["posts": post]
            NotificationCenter.default.post(name: Notification.Name("addToFavorite"), object: nil, userInfo: userInfo)
        
        case false:
            let predicate = NSPredicate(format: "title == %@", model.title)
            coreDataCoordinator.delete(PostsCoreDataModel.self, predicate: predicate) {  [weak self] result in
                self?.outputPosts[index].isLiked = false
            }
            let userInfo = ["posts": post]
            NotificationCenter.default.post(name: Notification.Name("removeFromFavorite"), object: nil, userInfo: userInfo)
        }
    }
}
