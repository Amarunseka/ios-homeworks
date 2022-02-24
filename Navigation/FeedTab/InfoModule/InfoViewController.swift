//
//  InfoViewController.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//

import UIKit
import SnapKit

class InfoViewController: UIViewController {
    
    private let planetURL = URL(string: "https://swapi.dev/api/planets/1")
    private var residentsOfTatooine: [String] = []
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        return tableView
    }()
    
    private lazy var buttonAlert: CustomButton = {
        let button = CustomButton(
               title: "Alert",
               backgroundColor: .systemRed,
               fontSize: 30,
               fontWeight: .regular){
                   [weak self] in
                   self?.showAlert()
               }
        return button
    }()
    
    private var firstTaskLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBlue
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private var secondTaskLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGreen
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupConstraints()
        setupButtonAlert()
        firstTaskLabel.text = "TASK №1\nTitle: \(SerializationNetworkService.receivePost())"
        receivePlanetInfo()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }


    private func setupView(){
        self.view.backgroundColor = UIColor.purple
        self.view.addSubview(tableView)
        self.view.addSubview(buttonAlert)
        self.view.addSubview(firstTaskLabel)
        self.view.addSubview(secondTaskLabel)
    }
    
    private func setupTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self

        tableView.backgroundColor = .systemGray2
    }
    
    
    private func setupButtonAlert( ){
        buttonAlert.layer.cornerRadius = 15
        buttonAlert.layer.masksToBounds = true
    }
    
    private func receivePlanetInfo(){
        
        NetworkService.receiveObject(url: self.planetURL, model: Planet.self) { [weak self ] result in
            switch result {
            case .success(let objectInfo):
                if let planetInfo = objectInfo as? Planet {
                    self?.secondTaskLabel.text = "TASK №2\nOrbital period of Tatooine: \(planetInfo.orbitalPeriod) days"
                    
                    for residentURL in planetInfo.residents {
                        self?.receiveResidentInfo(url: residentURL)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func receiveResidentInfo(url: String) {
        let url = URL(string: url)
        NetworkService.receiveObject(url: url, model: Resident.self) { [weak self ] result in
            switch result {
            case .success(let objectInfo):
                if let residentInfo = objectInfo as? Resident {
                    self?.residentsOfTatooine.append(residentInfo.name)
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func setupConstraints(){

        buttonAlert.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
            make.width.equalTo(150)
        }

        firstTaskLabel.snp.makeConstraints { make in
            make.top.equalTo(buttonAlert.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
            make.width.equalToSuperview().inset(20)
        }

        secondTaskLabel.snp.makeConstraints { make in
            make.top.equalTo(firstTaskLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
            make.width.equalToSuperview().inset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(secondTaskLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(10)
            make.right.left.equalToSuperview().inset(10)
        }
    }
    
    
    private func showAlert() {
        let alert = UIAlertController(title: "Наташа мы все уронили", message: "Воообще все!!!", preferredStyle: .alert)
        let angryAnswer = UIAlertAction(title: "У кого то теперь будут новые варежки", style: .destructive)
        let kindAnswer = UIAlertAction(title: "Ну хотя бы выспалась", style: .default)
        
        alert.addAction(angryAnswer)
        alert.addAction(kindAnswer)
        self.present(alert, animated: true, completion: nil)
    }
}


extension InfoViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residentsOfTatooine.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        let resident = residentsOfTatooine[indexPath.row]
        cell.textLabel?.text = resident
        return cell
    }
}

