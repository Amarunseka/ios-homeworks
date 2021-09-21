//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//


import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    
    var showAlert: (() -> Void)?
    
    let avatarImageView: UIImageView = {
        let badgerImage = UIImageView()
        badgerImage.contentMode = .scaleToFill
        return badgerImage
    }()
    
    
    var fullNameLabel: UILabel = {
        let text = UILabel()
        text.numberOfLines = 0
        text.font = .systemFont(ofSize: 18, weight: .bold)
        text.sizeToFit()
        text.backgroundColor = .clear
        text.textColor = .black
        return text
    }()
    

    let statusLabel: UILabel = {
        let text = UILabel()
        text.numberOfLines = 0
        text.font = .systemFont(ofSize: 14, weight: .regular)
        text.sizeToFit()
        text.backgroundColor = .clear
        text.textColor = .darkGray
        return text
    }()
    
    
    let setStatusButton: UIButton  = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle("Edit status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    let statusTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "write something"
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.tintColor = .black
        return textField
    }()
    
    let footerLineView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemGray2
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray6

        setupView()
        //setupFullNameLabel()
        setupSetStatusButton()
        setupConstraints()
        setupStatusTextField()
        setupFooterLineView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAvatar()
    }
    
    
// MARK: - Setups
    
    func setupView(){
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(setStatusButton)
        addSubview(statusTextField)
        addSubview(footerLineView)
    }
    
    
    func setupAvatar() {
        avatarImageView.layer.cornerRadius = 4
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
    }
    
    
    func setupFullNameLabel(){
        let textFullNameLabel = NSMutableAttributedString(string: "Honeybadger don't care")
        let don_tCareText = (textFullNameLabel.string as NSString).range(of: "don't care")
        
        textFullNameLabel.setAttributes([
            .foregroundColor: UIColor.red,
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ], range: don_tCareText)
        
        self.fullNameLabel.attributedText = textFullNameLabel
    }
    
    
    func setupSetStatusButton(){
        setStatusButton.layer.cornerRadius = 4
        setStatusButton.layer.shadowOpacity = 0.7
        setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        setStatusButton.layer.shadowRadius = 4
        setStatusButton.layer.shadowColor = UIColor.black.cgColor
        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }

    
    func setupStatusTextField(){
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.layer.cornerRadius = 12
        statusTextField.tintColor = .customColorBlue
    }
    
    func setupFooterLineView(){
        footerLineView.layer.shadowOpacity = 1
        footerLineView.layer.shadowOffset = CGSize(width: 0, height: 2)
        footerLineView.layer.shadowRadius = 4
        footerLineView.layer.shadowColor = UIColor.black.cgColor
    }
    

    // MARK: - Constraints
    
    func setupConstraints(){
        
        avatarImageView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.width.equalTo(100)
        }


        fullNameLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(safeAreaLayoutGuide).inset(27)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(20)
            make.trailing.equalTo(safeAreaInsets).inset(16)
            make.height.equalTo(20)
        }
        
        
        setStatusButton.snp.makeConstraints{ (make) in
            make.leading.equalTo(avatarImageView)
            make.trailing.equalTo(fullNameLabel)
            make.top.equalTo(avatarImageView.snp.bottom).offset(16)
            make.height.equalTo(50)
        }

 
        statusLabel.snp.makeConstraints{ (make) in
            make.leading.equalTo(fullNameLabel)
            make.bottom.equalTo(setStatusButton.snp.top).inset(-50)
            make.trailing.equalTo(fullNameLabel)
            make.height.equalTo(20)
        }

        
        statusTextField.snp.makeConstraints{ (make) in
            make.leading.equalTo(fullNameLabel)
            make.trailing.equalTo(fullNameLabel)
            make.top.equalTo(statusLabel.snp.bottom).offset(5)
            make.height.equalTo(40)
        }

        
        footerLineView.snp.makeConstraints{ (make) in
            make.top.equalTo(setStatusButton.snp.bottom).offset(10)
            make.height.equalTo(2)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    
// MARK: - target functions
    
    @objc func buttonPressed(){
        guard let text = statusTextField.text else {return}
        
        if text.isEmpty == true {
            if let tap = showAlert{ tap() }
        } else {
            statusLabel.text = text
            statusTextField.text = nil
        }
    }

    func clearStatus(){
        statusLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
