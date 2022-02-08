//
//  AudioViewModel.swift
//  Navigation
//
//  Created by Миша on 22.12.2021.
//

import Foundation

class AudioViewModel {
    
    var mp3Player: MP3Player?
    var trackName: String?
    var trackCurentTime: String?
    var trackProgress: Float?
    
    init(){
        mp3Player = MP3Player()
        setupNotificationCenter()
    }

    
    func updateViews(){
        trackCurentTime = mp3Player?.getCurrentTimeAsString()
    }
    
    
    @objc private func setTrackName(){
        trackName = mp3Player?.getCurrentTrackName()
    }
    
    
    private func setupNotificationCenter(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(setTrackName),
            name: NSNotification.Name(rawValue: "setTrackName"),
            object: nil)
    }
    
    // MARK: - Actions
    func playSong() {
        setTrackName()
        updateViews()
        mp3Player?.play()
    }
        
    func stopSong() {
        mp3Player?.stop()
        updateViews()
    }
    
    func pauseSong() {
        mp3Player?.pause()
    }
    
    func playNextSong() {
        mp3Player?.nextSong(false)
    }
    
    func playPreviousSong() {
        mp3Player?.previousSong()
    }
}
