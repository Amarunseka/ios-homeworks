//
//  CreateNewUserViewController.swift
//  Navigation
//
//  Created by Миша on 02.03.2022.
//

import UIKit


class CreateNewUserViewController: UIViewController {

    let defaults = UserDefaults.standard
    let coordinator = LoginCoordinator()
    let viewModel: CreateNewUserViewModel
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        titleLabel.textColor = .customColorBlue
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines =  1
        titleLabel.text = "New Account"
        return titleLabel
    }()
    
    
    let emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "Email"
        emailTextField.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        emailTextField.textColor = UIColor.black
        emailTextField.tintColor = .accentColor
        emailTextField.autocapitalizationType = .none
        emailTextField.backgroundColor = .systemGray6
        emailTextField.leftViewMode = .always
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.borderColor = UIColor.black.cgColor
        emailTextField.layer.cornerRadius = 12
        emailTextField.addTarget(self, action: #selector(activateCreateButton), for: .allEvents)
        return emailTextField
    }()

    
    
    let loginTextField: UITextField = {
        let loginTextField = UITextField()
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = "Login"
        loginTextField.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        loginTextField.textColor = UIColor.black
        loginTextField.tintColor = .accentColor
        loginTextField.autocapitalizationType = .none
        loginTextField.backgroundColor = .systemGray6
        loginTextField.leftViewMode = .always
        loginTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        loginTextField.layer.borderWidth = 0.5
        loginTextField.layer.borderColor = UIColor.black.cgColor
        loginTextField.layer.cornerRadius = 12
        loginTextField.addTarget(self, action: #selector(activateCreateButton), for: .allEvents)
        return loginTextField
    }()

    
    let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        passwordTextField.textColor = UIColor.black
        passwordTextField.tintColor = .accentColor
        passwordTextField.autocapitalizationType = .none
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.leftViewMode = .always
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.cornerRadius = 12
        passwordTextField.addTarget(self, action: #selector(activateCreateButton), for: .allEvents)
        return passwordTextField
    }()
    
    
    let password2TextField: UITextField = {
        let password2TextField = UITextField()
        password2TextField.translatesAutoresizingMaskIntoConstraints = false
        password2TextField.placeholder = "Again Password"
        password2TextField.isSecureTextEntry = true
        password2TextField.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        password2TextField.textColor = UIColor.black
        password2TextField.tintColor = .accentColor
        password2TextField.autocapitalizationType = .none
        password2TextField.backgroundColor = .systemGray6
        password2TextField.leftViewMode = .always
        password2TextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        password2TextField.layer.borderWidth = 0.5
        password2TextField.layer.borderColor = UIColor.black.cgColor
        password2TextField.layer.cornerRadius = 12
        password2TextField.addTarget(self, action: #selector(activateCreateButton), for: .allEvents)
        return password2TextField
    }()
    
    
    let createButton: UIButton = {
        let createButton = UIButton()
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        createButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        createButton.setTitleColor(.white, for: .normal)
        createButton.setTitle("Create account", for: .normal)
        createButton.addTarget(self, action: #selector(saveUser), for: .touchUpInside)
        createButton.isEnabled = false
        createButton.alpha = 0.5
        return createButton
    }()
    
    init(viewModel:CreateNewUserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    func setupView(){
        view.backgroundColor = .white

        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(password2TextField)
        view.addSubview(createButton)
        
        emailTextField.delegate = self
        loginTextField.delegate = self
        passwordTextField.delegate = self
        password2TextField.delegate = self
    }
    
    
    @objc private func saveUser(){

        guard passwordTextField.text == password2TextField.text else {
            print("пароли не совпадают")
            return}


        if let email = emailTextField.text,
           let login = loginTextField.text,
           let password = passwordTextField.text {

            viewModel.createNewUser(email: email, login: login, password: password)
        }
    }
    

     @objc private func activateCreateButton(){
        if let email = emailTextField.text, !email.isEmpty,
           let login = loginTextField.text, !login.isEmpty,
           let password = passwordTextField.text, !password.isEmpty,
           let password2 = password2TextField.text, !password2.isEmpty {

            createButton.isEnabled = true
            createButton.alpha = 1
        } else {
            createButton.isEnabled = false
            createButton.alpha = 0.5
        }
    }

    func setupConstraints(){
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -20),
            
            
            emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            
            loginTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loginTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            loginTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),


            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 15),
            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

            
            password2TextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            password2TextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            password2TextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            password2TextField.heightAnchor.constraint(equalToConstant: 50),

            
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createButton.topAnchor.constraint(equalTo: password2TextField.bottomAnchor, constant: 60),
            createButton.heightAnchor.constraint(equalToConstant: 40),
            createButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -150)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}


// MARK: - other extensions

extension CreateNewUserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        saveUser()
        return true
    }
}

