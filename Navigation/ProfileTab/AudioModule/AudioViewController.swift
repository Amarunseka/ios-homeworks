//
//  AudioViewController.swift
//  Navigation
//
//  Created by Миша on 22.12.2021.
//

import UIKit

class AudioViewController: UIViewController {

    private let toggleMenu: (() -> Void)
    private var timer: Timer?
    private var viewModel: AudioViewModel

    init(toggleMenu: @escaping (() -> Void), viewModel: AudioViewModel){
        self.toggleMenu = toggleMenu
        self.viewModel = viewModel
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var menuButton: UIButton = {
        let button = CustomButton(
            titleColor: .black,
            backgroundImage: UIImage(systemName: "list.dash"),
            highlighted: .yes) { [weak self] in
                self?.toggleMenu()
            }
        button.tintColor = UIColor(named: "customBlue")
        return button
    }()
    
    
    /// MP3 Player view elements
    private lazy var titleLabel = UILabel()
    private lazy var trackNameLabel = UILabel()
    private lazy var trackTimeLabel = UILabel()
    private lazy var progressBarSlider = UISlider()
    private lazy var setVolumeSlider = UISlider()
    
    
    private let backgroundView = UIImageView()
    private let playerView = UIImageView()
    private var backButton = UIButton()
    private var wrdButton = UIButton()
    private var playButton = UIButton()
    private var pauseButton = UIButton()
    private var stopButton = UIButton()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        setupView()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.isToolbarHidden = false
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundView.frame = view.bounds
    }
    
    
    private func setupView() {
        /// setup background
        view.addSubview(backgroundView)
        backgroundView.image = UIImage(named: "background")

        
        /// setup menuButton
        view.addSubview(menuButton)
        menuButton.translatesAutoresizingMaskIntoConstraints = false

        
        /// setup playerView
        backgroundView.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.image = UIImage(named: "player")
        
        
        /// create player buttons
        playButton = createMP3PlayerButton(playButton, image: "play")
        stopButton = createMP3PlayerButton(stopButton, image: "stop")
        pauseButton = createMP3PlayerButton(pauseButton, image: "pause")
        wrdButton = createMP3PlayerButton(wrdButton, image: "fwd")
        backButton = createMP3PlayerButton(backButton, image: "back")
        
        
        /// add target for player buttons
        playButton.addTarget(self, action: #selector(playSong), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopSong), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(pauseSong), for: .touchUpInside)
        wrdButton.addTarget(self, action: #selector(playNextSong), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(playPreviousSong), for: .touchUpInside)
        
        
        /// setup TitleLabel
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Audio Player"
        titleLabel.textColor = UIColor(named: "customBlue")
        titleLabel.numberOfLines = 1
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.sizeToFit()
        titleLabel.backgroundColor = .clear

        
        /// setup NameLabel
        playerView.addSubview(trackNameLabel)
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        trackNameLabel.text = "..."
        trackNameLabel.textColor = .white
        trackNameLabel.sizeToFit()
        trackNameLabel.numberOfLines = 1
        trackNameLabel.font = UIFont.systemFont(ofSize: 20)
        
        
        /// setup trackTimeLabel
        playerView.addSubview(trackTimeLabel)
        trackTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        trackTimeLabel.text = "... : ..."
        trackTimeLabel.textColor = .white
        trackTimeLabel.sizeToFit()
        trackTimeLabel.numberOfLines = 1
        trackTimeLabel.font = UIFont.systemFont(ofSize: 23)
        
        
        /// setup volume Slider
        view.addSubview(setVolumeSlider)
        setVolumeSlider.translatesAutoresizingMaskIntoConstraints = false
        setVolumeSlider.minimumValue = 0
        setVolumeSlider.maximumValue = 5
        setVolumeSlider.value = 2.5
        setVolumeSlider.tintColor = UIColor(named: "customBlue")
        setVolumeSlider.setThumbImage(UIImage(named: "circ"), for: .normal)
        setVolumeSlider.addTarget(self, action: #selector(setVolume), for: .valueChanged)

        
        /// setup progress Slider
        view.addSubview(progressBarSlider)
        progressBarSlider.translatesAutoresizingMaskIntoConstraints = false
        progressBarSlider.minimumValue = 0
        progressBarSlider.maximumValue = 1
        progressBarSlider.value = 0
        progressBarSlider.tintColor = UIColor(named: "customBlue")
        progressBarSlider.setThumbImage(UIImage(named: "circ"), for: .normal)
        progressBarSlider.addTarget(self, action: #selector(setCurrentTime), for: .valueChanged)
        
        /// constraints
        setupConstraints()
    }
    
    
    private func setupConstraints(){

        let constraints = [
            menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            menuButton.heightAnchor.constraint(equalToConstant: 30),
            menuButton.widthAnchor.constraint(equalToConstant: 30),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            playerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
            playerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerView.heightAnchor.constraint(equalToConstant: 150),
            playerView.widthAnchor.constraint(equalToConstant: 380),
            
            playButton.centerXAnchor.constraint(equalTo: playerView.centerXAnchor, constant: 3),
            playButton.bottomAnchor.constraint(equalTo: playerView.bottomAnchor, constant: -8),
            playButton.heightAnchor.constraint(equalToConstant: 18),
            playButton.widthAnchor.constraint(equalToConstant: 22),

            pauseButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -35),
            pauseButton.bottomAnchor.constraint(equalTo: playButton.bottomAnchor, constant: -2),
            pauseButton.heightAnchor.constraint(equalTo: playButton.heightAnchor, constant: -5),
            pauseButton.widthAnchor.constraint(equalTo: playButton.widthAnchor, constant: -5),

            backButton.trailingAnchor.constraint(equalTo: pauseButton.leadingAnchor, constant: -28),
            backButton.bottomAnchor.constraint(equalTo: pauseButton.bottomAnchor),
            backButton.heightAnchor.constraint(equalTo: pauseButton.heightAnchor),
            backButton.widthAnchor.constraint(equalTo: pauseButton.widthAnchor),
            
            stopButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 28),
            stopButton.bottomAnchor.constraint(equalTo: pauseButton.bottomAnchor),
            stopButton.heightAnchor.constraint(equalTo: pauseButton.heightAnchor),
            stopButton.widthAnchor.constraint(equalTo: pauseButton.widthAnchor),

            wrdButton.leadingAnchor.constraint(equalTo: stopButton.trailingAnchor, constant: 28),
            wrdButton.bottomAnchor.constraint(equalTo: pauseButton.bottomAnchor),
            wrdButton.heightAnchor.constraint(equalTo: pauseButton.heightAnchor),
            wrdButton.widthAnchor.constraint(equalTo: pauseButton.widthAnchor),
            
            trackNameLabel.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: 100),
            trackNameLabel.topAnchor.constraint(equalTo: playerView.topAnchor, constant: 50),
            trackNameLabel.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: -32),
            
            trackTimeLabel.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: 22),
            trackTimeLabel.bottomAnchor.constraint(equalTo: trackNameLabel.bottomAnchor),
            trackTimeLabel.trailingAnchor.constraint(equalTo: trackNameLabel.leadingAnchor, constant: -10),
                        
            setVolumeSlider.topAnchor.constraint(equalTo: playerView.topAnchor, constant: 12),
            setVolumeSlider.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: 20),
            setVolumeSlider.widthAnchor.constraint(equalToConstant: 80),
            
            progressBarSlider.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 7),
            progressBarSlider.leadingAnchor.constraint(equalTo: trackNameLabel.leadingAnchor, constant: 3),
            progressBarSlider.trailingAnchor.constraint(equalTo: trackNameLabel.trailingAnchor, constant: -3)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    
    private func startTimer(){
        timer = Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(updateViewsWithTimer),
            userInfo: nil,
            repeats: true)
    }
    
    @objc func updateViewsWithTimer(theTimer: Timer){
        viewModel.updateViews()
        trackTimeLabel.text = viewModel.trackCurentTime
        progressBarSlider.value = Float(viewModel.mp3Player?.player?.currentTime ?? 0)
    }
    
    
    // MARK: - Actions
    @objc private func playSong() {
        viewModel.playSong()
        progressBarSlider.maximumValue = Float(viewModel.mp3Player?.player?.duration ?? 1)
        trackNameLabel.text = viewModel.trackName
        startTimer()
    }
        
    @objc private func stopSong() {
        viewModel.stopSong()
        trackTimeLabel.text = viewModel.trackCurentTime
        progressBarSlider.value = 0
        timer?.invalidate()
    }
    
    @objc private func pauseSong() {
        viewModel.pauseSong()
        timer?.invalidate()
    }
    
    @objc private func playNextSong() {
        viewModel.playNextSong()
        progressBarSlider.maximumValue = Float(viewModel.mp3Player?.player?.duration ?? 1)
        trackNameLabel.text = viewModel.trackName
        startTimer()
    }
    
    @objc private func playPreviousSong() {
        viewModel.playPreviousSong()
        progressBarSlider.maximumValue = Float(viewModel.mp3Player?.player?.duration ?? 1)
        trackNameLabel.text = viewModel.trackName
        startTimer()
    }
    
    @objc private func setVolume(_ sender: UISlider) {
        viewModel.mp3Player?.setVolume(sender.value)
    }
    
    @objc private func setCurrentTime(_ sender: UISlider) {
        if sender == progressBarSlider {
            progressBarSlider.maximumValue = Float(viewModel.mp3Player?.player?.duration ?? 1)
            viewModel.mp3Player?.player?.stop()
            viewModel.mp3Player?.player?.currentTime = TimeInterval(sender.value)
            viewModel.mp3Player?.player?.prepareToPlay()
            viewModel.mp3Player?.player?.play()
        }
    }
}
