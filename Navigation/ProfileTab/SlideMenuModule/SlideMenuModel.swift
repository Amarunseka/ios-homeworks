//
//  SlideMenuModel.swift
//  Navigation
//
//  Created by Миша on 21.12.2021.
//

import UIKit


enum SlideMenuModel: String, CaseIterable {
    
    case profile = "Profile"
    case audio = "Audio"
    case video = "Video"
    case localVideo = "LocalVideo"
    case logout

    var image: UIImage {
        switch self {
            case .profile: return UIImage(named: "honeybadger") ?? UIImage()
            case .audio: return UIImage(systemName: "beats.headphones") ?? UIImage()
            case .video: return UIImage(systemName: "play.rectangle.on.rectangle.fill") ?? UIImage()
            case .localVideo: return UIImage(systemName: "play.rectangle") ?? UIImage()
        case.logout: return UIImage(systemName: "return") ?? UIImage()
        }
    }
}
