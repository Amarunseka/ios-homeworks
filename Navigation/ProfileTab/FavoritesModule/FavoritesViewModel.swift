//
//  FavoritesViewModel.swift
//  Navigation
//
//  Created by Миша on 26.07.2022.
//

import UIKit
import StorageService

class FavoritesViewModel {
    
    weak var coordinator: FavoritesCoordinator?
    private let coreDataCoordinator = CoreDataCoordinatorManager.shared.coreDataCoordinator
    var posts: [Post] = []
    var outputReloadTableView: (()->())?
    
    init(){
        fetchData()
        setupNotificationCenter()
    }

    private func setupNotificationCenter(){
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addToFavorite(_:)),
                                               name: NSNotification.Name("addToFavorite"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removeFromFavorite(_:)),
                                               name: NSNotification.Name("removeFromFavorite"),
                                               object: nil)
    }
    
    @objc
    private func addToFavorite(_ notification: NSNotification) {
        if let post = notification.userInfo?["posts"] as? Post {
            posts.insert(post, at: 0)
            
            guard let outputReloadTableView = outputReloadTableView else {return}
            outputReloadTableView()
        }
    }
    
    @objc
    private func removeFromFavorite(_ notification: NSNotification) {
        guard !posts.isEmpty,
              let post = notification.userInfo?["posts"] as? Post
        else {return}
        
        if let index = posts.firstIndex(where: { $0.title == post.title}) {
            posts.remove(at: index)
            
            guard let outputReloadTableView = self.outputReloadTableView else {return}
            outputReloadTableView()
        }
    }
    
    private func fetchData(){
        posts.removeAll()
        coreDataCoordinator.fetchAll(PostsCoreDataModel.self) { [weak self] result in
            switch result {
            case .success(let models):
                guard !models.isEmpty else {return}
                models.forEach {
                    self?.containPostFromCoreData(from: $0)
                }
            case .failure(let error):
                print("Error: \(error)")
            }
            guard let outputReloadTableView = self?.outputReloadTableView else {return}
            outputReloadTableView()
        }
    }

    private func containPostFromCoreData(from data: PostsCoreDataModel) {
        let data = data
        let post = Post(title: data.title ?? "",
                        image: data.image ?? "",
                        postDescription: data.postDescription ?? "",
                        author: data.author ?? "",
                        likes: Int(data.likes),
                        views: Int(data.views),
                        isLiked: data.isLiked)

        self.posts.insert(post, at: 0)
    }
}
