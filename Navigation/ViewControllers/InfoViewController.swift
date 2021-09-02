//
//  InfoViewController.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    let buttonAlert: UIButton = {
        let button = UIButton()
        button.setTitle("Alert", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        button.backgroundColor = .systemRed
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showAlert(parameterSender:)), for: .touchUpInside)
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
    
    
    func setupView(){
        self.view.backgroundColor = UIColor.purple
        self.view.addSubview(buttonAlert)
    }
    
    
    func setupButtonAlert( ){
        buttonAlert.layer.cornerRadius = 15
        buttonAlert.layer.masksToBounds = true
    }
    
    
    func buttonAlertConstraints() {
        let constraints = [
            buttonAlert.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            buttonAlert.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            buttonAlert.widthAnchor.constraint(equalToConstant: 150),
            buttonAlert.heightAnchor.constraint(equalToConstant: 70)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    @objc func showAlert (parameterSender: Any) {
        let alert = UIAlertController(title: "Наташа мы все уронили", message: "Воообще все!!!", preferredStyle: .alert)
        let angryAnswer = UIAlertAction(title: "У кого то теперь будут новые варежки", style: .destructive)
        let kindAnswer = UIAlertAction(title: "Ну хотя бы выспалась", style: .default)
        
        alert.addAction(angryAnswer)
        alert.addAction(kindAnswer)
        self.present(alert, animated: true, completion: nil)
    }
}
