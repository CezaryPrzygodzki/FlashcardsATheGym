//
//  FlashcardAnswer.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 21/04/2021.
//

import UIKit

class FlashcardAnswer: UIView {

    private var flashcard: Flashcard
    private var flashcardFrame: CGRect

    private let meaningLabel = UILabel()
    private let translationLabel = UILabel()
    private let exampleLabel = UILabel()
    
    
    init(flashcard: Flashcard, frame: CGRect) {
        self.flashcard = flashcard
        self.flashcardFrame = frame

        super.init(frame: frame)

        backgroundColor = Colors.FATGWhiteBlack
        self.layer.cornerRadius = 10
    
        configurelabels()
        addSubview(meaningLabel)
        addSubview(translationLabel)
        addSubview(exampleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurelabels(){
        
        let padding: CGFloat = 20
        meaningLabel.text = flashcard.meaning
        meaningLabel.textColor = Colors.FATGtext
        meaningLabel.textAlignment = .left
        meaningLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        meaningLabel.numberOfLines = 0
        meaningLabel.frame = CGRect(x: padding,
                                    y: (flashcard.meaning == "") ? (0) : (padding),
                                    width: flashcardFrame.size.width - padding * 2,
                                    height: 20)
        meaningLabel.sizeToFit()
        
        translationLabel.text = flashcard.translation
        translationLabel.textColor = Colors.FATGtext
        translationLabel.textAlignment = .left
        translationLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        translationLabel.numberOfLines = 0
        translationLabel.frame = CGRect(x: padding,
                                        y: meaningLabel.frame.origin.y + meaningLabel.frame.size.height + ((flashcard.translation == "") ? (0) : (padding)),
                                        width: flashcardFrame.size.width - padding * 2,
                                        height: 20)
        translationLabel.sizeToFit()
        
        exampleLabel.text = flashcard.example
        exampleLabel.textColor = Colors.FATGtext
        exampleLabel.textAlignment = .center
        exampleLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        exampleLabel.numberOfLines = 0
        exampleLabel.frame.size.width = flashcardFrame.size.width - padding * 2
        exampleLabel.frame.size.height = 20
        exampleLabel.sizeToFit()
        exampleLabel.frame = CGRect(x: flashcardFrame.size.width / 2 - exampleLabel.frame.size.width / 2,
                                    y: translationLabel.frame.origin.y + translationLabel.frame.size.height + ((flashcard.example == "") ? (0) : (padding)),
                                    width: exampleLabel.frame.size.width,
                                    height: exampleLabel.frame.size.height)
    }

}
