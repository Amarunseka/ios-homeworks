//
//  MP3Player.swift
//  Navigation
//
//  Created by Миша on 08.12.2021.
//

import UIKit
import AVFoundation
 
class MP3Player: NSObject, AVAudioPlayerDelegate {
    var player:AVAudioPlayer?
    private var currentTrackIndex = 0
    private var tracks:[String] = []
    
    
    override init(){
        tracks = MP3FilesReader.readFiles()
        super.init()
        queueTrack()
    }
    
    // MARK: - getting a track
    private func queueTrack(){
        if (player != nil) {
            player = nil
        }
        
        lazy var error:NSError? = nil
        
        let url = URL.init(fileURLWithPath: tracks[currentTrackIndex])
        player = try? AVAudioPlayer(contentsOf: url)
        
        if error != nil {
            print("Track is not found")
        } else {
            player?.delegate = self
            player?.prepareToPlay()
            NotificationCenter.default.post(
                name: NSNotification.Name(rawValue: "setTrackName"),
                object: nil)
            NotificationCenter.default.post(
                name: NSNotification.Name(rawValue: "setTrackDuration"),
                object: nil)
        }
    }
    
    
    // MARK: - play-pause-stop
    func play() {
        if player?.isPlaying == false {
            player?.play()
        }
    }
    
    func stop(){
        if let currentTime = player?.currentTime,
           currentTime > 0 {
            player?.stop()
            player?.currentTime = 0
        }
    }
    
    func pause(){
        if player?.isPlaying == true{
            player?.pause()
        }
    }
    
    
    
    // MARK: - Next song
    func nextSong(_ songFinishedPlaying: Bool){
        var playerWasPlaying = false
        if player?.isPlaying == true {
            player?.stop()
            playerWasPlaying = true
        }
        
        currentTrackIndex += 1
        if currentTrackIndex >= tracks.count {
            currentTrackIndex = 0
        }
        
        queueTrack()
        if playerWasPlaying || songFinishedPlaying {
            player?.play()
        }
    }
    
    
    // MARK: - Previous song
    func previousSong(){
        var playerWasPlaying = false
        if player?.isPlaying == true {
            player?.stop()
            playerWasPlaying = true
        }
        
        currentTrackIndex  -= 1
        if currentTrackIndex < 0 {
            currentTrackIndex = tracks.count - 1
        }
        
        queueTrack()
        if playerWasPlaying {
            player?.play()
        }
    }
    
    
    // MARK: - getting a track number
    func getCurrentTrackName() -> String {
        let tempName = URL(fileURLWithPath: tracks[currentTrackIndex]).deletingPathExtension().lastPathComponent
        let trackName = tempName.replacingOccurrences(of: "_", with: " ")
        return trackName
    }
    
    
    // MARK: - convert a track current time format
    func getCurrentTimeAsString() -> String {
        var seconds = 0
        var minutes = 0
        if let time = player?.currentTime {
            seconds = Int(time) % 60
            minutes = (Int(time) / 60) % 60
        }
        return String(format: "%0.2d:%0.2d", minutes, seconds)
    }
    

    // MARK: - volume
    func setVolume(_ volume:Float){
        player?.volume = volume
    }
    
    
    // MARK: - duration
    func setTime(_ time: Float) {
        player?.currentTime = Double(time)
    }
    
    
    // MARK: - play next song
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        if flag == true {
            nextSong(true)
        }
    }
}
