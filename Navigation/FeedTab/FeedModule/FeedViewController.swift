//
//  FeedViewController.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//

import UIKit
import SnapKit
import StorageService

class FeedViewController: UIViewController {
    
    var viewModel: FeedViewModel
    var inputWordObservation: NSKeyValueObservation?

    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 100
        return stack
    }()
    
    
    private lazy var postButton = createButton(
        title: "THE POST",
        fontSize: 20,
        color: .systemGreen) {
            [weak self] in
        self?.viewModel.postButtonTapped?()
    }


    private lazy var checkTheWordButton = createButton(
        title: "Check the word:\n...",
        fontSize: 18,
        color: .systemTeal) {
            [weak self] in
        self?.checkWord()
    }
    
    
    lazy var textField: CustomTextField = {
        let textField = CustomTextField (
            textColor: .customColorBlue ?? .black,
            tintColor: .customColorBlue ?? .black,
            fontSize: 20,
            textAlignment: .center,
            placeholder: "Let's check your word",
            autoLayout: .yes)
        textField.addTarget(self, action: #selector(inputText), for: .editingChanged)
        textField.delegate = self
        return textField
    }()
    
    
    var showResultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 12
        label.textColor = .white
        label.clipsToBounds = true
        label.textAlignment = .center
        label.isHidden = false
        return label
    }()
    
    
    init(viewModel: FeedViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstrains()
        setupObservation()
    }
    
    
    private func setupView(){
        self.title = "Feed"
        self.view.backgroundColor = .customColorBlue
        self.view.addSubview(stackView)
        self.view.addSubview(textField)
        self.view.addSubview(showResultLabel)
        
        self.stackView.addArrangedSubview(postButton)
        self.stackView.addArrangedSubview(checkTheWordButton)
    }

    
    private func setupConstrains(){
        postButton.snp.makeConstraints{ make in
            make.height.equalTo(70)
            make.width.equalTo(150)
        }
        
        stackView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(300)
        }
        
        textField.snp.makeConstraints{ make in
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).offset(20)
        }
        
        showResultLabel.snp.makeConstraints{ make in
            make.width.height.equalTo(textField)
            make.centerX.equalToSuperview()
            make.top.equalTo(textField.snp.bottom).offset(10)
        }
    }
}


// MARK: - extension Checking Word Result
extension FeedViewController {  // ViewModel
    
    private func checkWord(){
        viewModel.inputTextForCheck = textField.text
        viewModel.inputLabel = showResultLabel
        viewModel.checkButtonTapped?()
        showResultLabel = viewModel.outputLabel ?? showResultLabel
    }
}


// MARK: - extension Observation

extension FeedViewController {

    @objc private func inputText(){
        viewModel.inputWordInit = textField.text
    }
}


// MARK: - extension Textfield

extension FeedViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        checkWord()
        return true
    }
}


// MARK: - Observation
extension FeedViewController {
    
    private func setupObservation(){
        
        inputWordObservation = viewModel.observe(\.inputWordInit, options: .new) {(vc, change) in
            guard let text = change.newValue as? String else {return}
            
            let initialButtonTitle = "Check the word:\n"
            let finishedButtonTitle = NSMutableAttributedString(string: initialButtonTitle + text)
            
            
            finishedButtonTitle.addAttributes(
                [.foregroundColor: UIColor.red,
                 .font: UIFont.systemFont(ofSize: 18, weight: .bold)],
                range: NSRange(location: initialButtonTitle.count,
                length: text.count))
            
            self.checkTheWordButton.setAttributedTitle(finishedButtonTitle, for: .normal)
        }
    }
}
