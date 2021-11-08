//
//  FeedViewController.swift
//  Navigation
//
//  Created by Миша on 01.09.2021.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {

    var postInfo = TitlePostPage(title: "Breaking news")
    private let checkerText: CheckText?
    private let stackView = UIStackView()
    
    @objc dynamic var inputWord: String?
    var inputWordObservation: NSKeyValueObservation?
    
    
    private lazy var textField: CustomTextField = {
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
    
    
    private let checkResultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 12
        label.textColor = .white
        label.clipsToBounds = true
        label.textAlignment = .center
        label.isHidden = false
        return label
    }()
    
    
    private lazy var toPostButton = createButton(
        title: "THE POST", fontSize: 20, color: .systemGreen) {
        [weak self] in
        let postVC = PostViewController()
        self?.navigationController?.pushViewController(postVC, animated: true)
    }
    
    
    private lazy var toCheckTheWordButton = createButton(
        title: "Check the word:\n...", fontSize: 18, color: .systemTeal) {
        [weak self] in
        self?.checkWord()
    }

    
    init(checkerText: CheckText?){
        self.checkerText = checkerText
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feed"
        view.backgroundColor = .customColorBlue
        view.addSubview(textField)
        view.addSubview(checkResultLabel)

        configureStackView()
        setupConstrains()
        setupObservation()
        print(view.frame.size.height)
    }

    
    private func configureStackView(){
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = view.frame.size.height / 10
        stackView.addArrangedSubview(toPostButton)
        stackView.addArrangedSubview(toCheckTheWordButton)
    }
    
    
    private func setupConstrains(){
        let constraints = [
            
            toPostButton.heightAnchor.constraint(equalToConstant: 70),
            toPostButton.widthAnchor.constraint(equalToConstant: 150),
            
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -40),
            
            textField.widthAnchor.constraint(equalToConstant: 300),
            textField.heightAnchor.constraint(equalToConstant: 40),
            textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textField.bottomAnchor.constraint(equalTo: checkResultLabel.topAnchor, constant: -10),
            
            checkResultLabel.widthAnchor.constraint(equalTo: textField.widthAnchor),
            checkResultLabel.heightAnchor.constraint(equalTo: textField.heightAnchor),
            checkResultLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            checkResultLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,
                                                     constant: -(view.frame.size.height / 5))
        ]
        NSLayoutConstraint.activate(constraints)
    }
}



// MARK: - extension CreateButton

extension FeedViewController {
    
    private func createButton(title: String, fontSize: CGFloat, color: UIColor, action: @escaping ()->Void) -> CustomButton {
        
        let button = CustomButton(
            title: title,
            backgroundColor: color,
            fontSize: fontSize,
            fontWeight: .regular,
            textAlignment: .center,
            highlighted: .yes,
            lineBreak: .byWordWrapping,
            buttonAction: action)
        
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        
        return button
    }
}

// MARK: - extension Checking Word Result
extension FeedViewController {
    
    private func checkWord(){
        guard let text = textField.text,
        !text.isEmpty,
        let checker = checkerText
        else { return }

        
        let showResult: (String, String) -> NSMutableAttributedString = {input, result in
            let initialText = "Your word: " + input
            let textResult = result
            let fullTextResult = NSMutableAttributedString(string: initialText + textResult)
            
            fullTextResult.addAttributes(
                [.foregroundColor: UIColor.black,
                 .font: UIFont.systemFont(ofSize: 18, weight: .bold)
                ],
                range: NSRange(location: initialText.count - text.count,
                length: text.count))
            return fullTextResult
        }
        
        
        if checker.check(text) {
            checkResultLabel.backgroundColor = .systemGreen
            checkResultLabel.attributedText = showResult(text, " - is correct")
            checkResultLabel.isHidden = false
        } else {
            checkResultLabel.backgroundColor = .systemRed
            checkResultLabel.attributedText = showResult(text, " - is wrong")
            checkResultLabel.isHidden = false
        }
    }
}



// MARK: - extension Observation

extension FeedViewController {

    @objc private func inputText(){
        inputWord = textField.text
    }
    
    
    private func setupObservation(){
        
        inputWordObservation = observe(\.inputWord, options: .new) {(vc, change) in
            guard let text = change.newValue as? String else {return}
            
            let initialButtonTitle = "Check the word:\n"
            let finishedButtonTitle = NSMutableAttributedString(string: initialButtonTitle + text)
            
            
            finishedButtonTitle.addAttributes(
                [.foregroundColor: UIColor.red,
                 .font: UIFont.systemFont(ofSize: 18, weight: .bold)],
                range: NSRange(location: initialButtonTitle.count,
                length: text.count))
            
            vc.toCheckTheWordButton.setAttributedTitle(finishedButtonTitle, for: .normal)
        }
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
