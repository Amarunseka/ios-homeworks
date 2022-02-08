//
//  YoutubePlayerView.swift
//  Navigation
//
//  Created by Миша on 23.12.2021.
//

import Foundation
import youtube_ios_player_helper

class YoutubePlayerView: YTPlayerView {
    let player = YTPlayerView()

    init(videoURL: String){
        super.init(frame: .zero)
        self.addSubview(player)
        setupConstraints()
        
        DispatchQueue.main.async { [weak self] in
            if let url = self?.createVideoIdentifier(videoURL) {
                self?.player.load(withVideoId: url)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func createVideoIdentifier(_ url: String) -> String {
        var videoIdentifier = ""
        let range = url.range(of: "=")
        if let index = range?.upperBound {
            videoIdentifier = String(url[index...])
        }
        return videoIdentifier
    }

    
    private func setupConstraints(){
        player.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            player.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            player.topAnchor.constraint(equalTo: self.topAnchor),
            player.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            player.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
