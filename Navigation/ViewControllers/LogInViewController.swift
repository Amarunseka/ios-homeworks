//
//  LogInViewController.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//

import UIKit

class LogInViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let logoView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logoVK")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    private let authenticationLabel: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let logInTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    
    private let passwordTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    
    private let logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    //MARK: - overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupAuthenticationLabelConstraints()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Setups
    
    private func setupMainView(){
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(logoView)
        containerView.addSubview(authenticationLabel)
        containerView.addSubview(logInButton)
        
        setupScrollView()
        setupAuthenticationLabel()
        setupLogInButton()
        setupMainViewConstraints()
    }
    
    
    private func setupScrollView(){
        scrollView.keyboardDismissMode = .onDrag
    }

    
    private func setupAuthenticationLabel(){
        authenticationLabel.layer.borderColor = UIColor.lightGray.cgColor
        authenticationLabel.layer.borderWidth = 0.5
        authenticationLabel.layer.cornerRadius = 10
        authenticationLabel.clipsToBounds = true
        
        authenticationLabel.addSubview(logInTextField)
        authenticationLabel.addSubview(passwordTextField)
        
        setupLogInTextField()
        setupPasswordTextField()
    }
    
    
    private func setupLogInTextField(){
        logInTextField.backgroundColor = .systemGray6
        logInTextField.placeholder = "Email or phone"
        logInTextField.textColor = UIColor.black
        logInTextField.font = .systemFont(ofSize: 16, weight: .regular)
        logInTextField.tintColor = .accentColor
        logInTextField.autocapitalizationType = .sentences
        logInTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: logInTextField.frame.height))
        logInTextField.leftViewMode = .always
        logInTextField.layer.borderColor = UIColor.lightGray.cgColor
        logInTextField.layer.borderWidth = 0.5
        logInTextField.delegate = self
    }
    
    
    private func setupPasswordTextField(){
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.placeholder = "Password"
        passwordTextField.textColor = UIColor.black
        passwordTextField.font = .systemFont(ofSize: 16, weight: .regular)
        passwordTextField.tintColor = .accentColor
        passwordTextField.autocapitalizationType = .none
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField.frame.height))
        passwordTextField.leftViewMode = .always
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self

    }
    
    
    private func setupLogInButton(){
        let backgroundOtherStates = UIImage(named: "blue_pixel")!.alpha(0.8)
        
        logInButton.setTitle("Log In", for: .normal)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.layer.cornerRadius = 10
        logInButton.clipsToBounds = true
        logInButton.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        logInButton.setBackgroundImage(backgroundOtherStates, for: .selected)
        logInButton.setBackgroundImage(backgroundOtherStates, for: .highlighted)
        logInButton.setBackgroundImage(backgroundOtherStates, for: .disabled)
        
        logInButton.addTarget(self, action: #selector(pushLogInButton), for: .touchUpInside)
    }
    
    
    // MARK: - Constraints
    
    private func setupMainViewConstraints(){
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            
            logoView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 120),
            logoView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            logoView.widthAnchor.constraint(equalToConstant: 100),
            logoView.heightAnchor.constraint(equalTo: logoView.widthAnchor),
            
            
            authenticationLabel.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 120),
            authenticationLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            authenticationLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -16 * 2),
            authenticationLabel.heightAnchor.constraint(equalToConstant: 100),
            
            
            logInButton.topAnchor.constraint(equalTo: authenticationLabel.bottomAnchor, constant: 16),
            logInButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            logInButton.widthAnchor.constraint(equalTo: authenticationLabel.widthAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    
    private func setupAuthenticationLabelConstraints(){
        let constraints = [
            logInTextField.topAnchor.constraint(equalTo: authenticationLabel.topAnchor),
            logInTextField.widthAnchor.constraint(equalTo: authenticationLabel.widthAnchor),
            logInTextField.heightAnchor.constraint(equalTo: authenticationLabel.heightAnchor, multiplier: 0.5),
            
            passwordTextField.bottomAnchor.constraint(equalTo: authenticationLabel.bottomAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: authenticationLabel.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: authenticationLabel.heightAnchor, multiplier: 0.5, constant: 0.5)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - target functions
    
    @objc private func pushLogInButton(){
        guard let text = logInTextField.text else {return}
        let user: UserServiceProtocol

        #if DEBUG
        user = TestUserService()
        #else
        user = CurrentUserService()
        #endif
        
        guard user.createUser(userName: text) != nil else { return showAlert()}

        let segue = ProfileViewController(userService: user, userName: text)
        navigationController?.pushViewController(segue, animated: true)
    }
    
    
    @objc private func keyboardWillShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    
    @objc private func keyboardWillHide(notification: NSNotification){
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
}


// MARK: - other extensions

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        pushLogInButton()
        return true
    }
    
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Ошибка", message: "Неверное имя пользователя", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default) { _ in
        }
        
        alertController.setValue(NSAttributedString(
                                    string: alertController.title!,
                                    attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular),
                                                 NSAttributedString.Key.foregroundColor: UIColor.accentColor ?? .black]),
                                 forKey: "attributedTitle")
        
        alertController.setValue(NSAttributedString(
                                    string: alertController.message!,
                                    attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15,weight: UIFont.Weight.regular),
                                                 NSAttributedString.Key.foregroundColor: UIColor.red]),
                                 forKey: "attributedMessage")
        
        alertController.view.tintColor = .customColorBlue
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
