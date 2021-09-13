//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//


import UIKit

class ProfileHeaderView: UIView {

    private var statusText = ""
    
    let avatarImageView: UIImageView = {
        let badgerImage = UIImageView()
        badgerImage.image = UIImage(named: "honeybadger")
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
        text.font = .systemFont(ofSize: 14, weight: .regular)
        text.text = "Looking to fress somebody"
        text.sizeToFit()
        text.numberOfLines = 0
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
        setupFullNameLabel()
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
        statusTextField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
    }
    
    func setupFooterLineView(){
        footerLineView.layer.shadowOpacity = 1
        footerLineView.layer.shadowOffset = CGSize(width: 0, height: 2)
        footerLineView.layer.shadowRadius = 4
        footerLineView.layer.shadowColor = UIColor.black.cgColor
    }
    

    // MARK: - Constraints
    
    
    func setupConstraints(){
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        setStatusButton.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        footerLineView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let constraints = [
            avatarImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            
            
            fullNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            fullNameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            
            setStatusButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor, constant: 0),
            statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -50),
            statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusLabel.heightAnchor.constraint(equalToConstant: statusLabel.frame.height),
            
            
            statusTextField.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 5),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            footerLineView.topAnchor.constraint(equalTo: setStatusButton.bottomAnchor, constant: 10),
            footerLineView.heightAnchor.constraint(equalToConstant: 2),
            footerLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            footerLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            
        ]
    
        NSLayoutConstraint.activate(constraints)
    }
    
    
    
// MARK: - target functions
    
    @objc func buttonPressed(){
        if statusTextField.text != nil {
            if !statusText.isEmpty {
                statusLabel.text = statusText
            }
        }
    }

    
    @objc func statusTextChanged(_ textField: UITextField) {
        if textField.text != nil {
            statusText = textField.text ?? ""}
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
