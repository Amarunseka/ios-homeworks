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
        self.view.addSubview(buttonAlert)
        self.view.addSubview(firstTaskLabel)
        self.view.addSubview(secondTaskLabel)
    }
    
    
    private func setupButtonAlert( ){
        buttonAlert.layer.cornerRadius = 15
        buttonAlert.layer.masksToBounds = true
    }
    
    private func receivePlanetInfo(){
        PlanetNetworkService.receivePlanetInfo(url: planetURL) { [self] result in
            switch result {
            case .success(let objectInfo):
                if let planetInfo = objectInfo as? Planet {
                    secondTaskLabel.text = "TASK №2\nOrbital period of Tatooine: \(planetInfo.orbitalPeriod) days"
                    for resident in planetInfo.residents {
                        residentsOfTatooine.append(resident)
                    }
                    print(residentsOfTatooine.count)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func setupConstraints(){
        buttonAlert.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(70)
            make.width.equalTo(150)
        }
        
        firstTaskLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalToSuperview().inset(20)
        }
        
        secondTaskLabel.snp.makeConstraints { make in
            make.top.equalTo(firstTaskLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalToSuperview().inset(20)
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
