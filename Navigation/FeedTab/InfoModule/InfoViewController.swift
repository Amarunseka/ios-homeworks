//
//  InfoViewController.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//

import UIKit
import SnapKit

class InfoViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        buttonAlertConstraints()
        setupButtonAlert ()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
   
    }


    private func setupView(){
        self.view.backgroundColor = UIColor.purple
        self.view.addSubview(buttonAlert)
    }
    
    
    private func setupButtonAlert( ){
        buttonAlert.layer.cornerRadius = 15
        buttonAlert.layer.masksToBounds = true
    }
    
    
    private func buttonAlertConstraints(){
        buttonAlert.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(70)
            make.width.equalTo(150)
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
