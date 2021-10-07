//
//  InfoViewController.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var buttonAlert: CustomButton = {
        let button = CustomButton(
               title: "Alert",
               backgroundColor: .systemRed,
               fontSize: 30,
               fontWeight: .regular,
               sizeToFit: .yes,
               autoLayout: .yes){
                   self.showAlert()
               }
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        buttonAlertConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        setupButtonAlert ()
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
        let constraints = [
            buttonAlert.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            buttonAlert.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            buttonAlert.widthAnchor.constraint(equalToConstant: 150),
            buttonAlert.heightAnchor.constraint(equalToConstant: 70)
        ]
        NSLayoutConstraint.activate(constraints)
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
