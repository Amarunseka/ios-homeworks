//
//  PostViewModel.swift
//  Navigation
//
//  Created by Миша on 08.11.2021.
//

import Foundation

class PostViewModel {
    weak var coordinator: PostCoordinator?

    func presentToInfo(){
        coordinator?.presentToInfo()
    }
}
