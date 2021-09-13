//
//  PhotosStorageFile.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//

import UIKit

public struct PhotosString {
    public static let photos: [String] = {
      var photos = [String]()
      for p in 1...27 {
           if photos.count < 9 {
               photos.append("col_0\(p)")
           } else {
               photos.append("col_\(p)")
           }
       }
       return photos
   }()
}


public struct PhotosImage {
    public static let photos: [UIImage?] = {
        var image = [UIImage?]()
        for i in 0...PhotosString.photos.count-1 {
            if let a = UIImage(named: PhotosString.photos[i]) {
                image.append(a)
            } else {continue}
        }
        return image
    }()
}

