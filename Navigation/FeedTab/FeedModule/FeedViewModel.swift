//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Миша on 08.11.2021.
//

import Foundation
import StorageService
import UIKit


class FeedViewModel: NSObject {
    
    weak var coordinator: FeedCoordinator?

    @objc dynamic var inputWordInit: String?
    var inputTextForCheck: String?
    var inputLabel: UILabel?
    var outputLabel: UILabel?
    var postInfo = TitlePostPage(title: "Breaking news")
    private let checkerText: CheckText?

    
    var postButtonTapped: (() -> Void)? {
        return {
            self.coordinator?.segueToPost()
        }
    }
    
    
    var checkButtonTapped: (() -> Void)? {
        guard self.inputTextForCheck?.isEmpty != true else {return nil}
        
        return {
                self.showLabel()
        }
    }
    
    
    init(checkerText: CheckText?){
        self.checkerText = checkerText
    }
}


// MARK: - CheckText and ShowResultLabel
extension FeedViewModel {
    
    private func textFieldForCheck() -> Bool {
        if
            let checker = checkerText,
            let text = inputTextForCheck,
            checker.check(text) {
            return true
        } else {
            return false
        }
    }

    
    private func showLabel(){
        guard
            let label = inputLabel,
            let text = inputTextForCheck
        else {return}
        
        if textFieldForCheck() {
            label.backgroundColor = .systemGreen
            label.attributedText = setupResultText(to: text, result: " - is correct")
        } else {
            label.backgroundColor = .systemRed
            label.attributedText = setupResultText(to: text, result: " - is wrong")
        }
        label.isHidden = false

        outputLabel = label
    }
    
    
    // customise textResult
    private func setupResultText(to checked: String, result: String) -> NSMutableAttributedString{
        
            let initialText = "Your word: " + checked
            let fullTextResult = NSMutableAttributedString(string: initialText + result)
            
            fullTextResult.addAttributes(
                [.foregroundColor: UIColor.black,
                 .font: UIFont.systemFont(ofSize: 18, weight: .bold)
                ],
                range: NSRange(location: initialText.count - checked.count,
                length: checked.count))
        return fullTextResult
    }
}
