//
//  VideoViewController.swift
//  Navigation
//
//  Created by Миша on 22.12.2021.
//

import UIKit

class VideoViewController: UIViewController {

    private let toggleMenu: (() -> Void)
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let tableHeaderView = VideoTableHeaderView()
    
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
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Video Player"
        label.textColor = UIColor(named: "customBlue")
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.sizeToFit()
        label.backgroundColor = .clear
        return label
    }()
    
    
    init(toggleMenu: @escaping (() -> Void)){
        self.toggleMenu = toggleMenu
        super .init(nibName: nil, bundle: nil)
        navigationController?.navigationBar.isHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "customGray1")
//        navigationController?.navigationBar.isHidden = true
        setupTableView()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    
    func setupTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "customGray1")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            VideoTableViewCell.self,
            forCellReuseIdentifier: String(describing: VideoTableViewCell.self))
        tableView.tableHeaderView = tableHeaderView
    }
    
    
    private func setupConstraints(){
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menuButton)
        view.addSubview(titleLabel)

        let constraints = [
            menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            menuButton.heightAnchor.constraint(equalToConstant: 30),
            menuButton.widthAnchor.constraint(equalToConstant: 30),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}


// MARK: - UITableViewDataSource
extension VideoViewController: UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: VideoTableViewCell.self)) as! VideoTableViewCell
        cell.video = Videos.videosStorage[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Videos.videosStorage.count
    }
    
}


// MARK: - UITableViewDelegate
extension VideoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoVC = ShowVideoViewController(video: Videos.videosStorage[indexPath.row])
        self.navigationController?.pushViewController(videoVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
