//
//  FlashcardQuestion.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 20/04/2021.
//

import UIKit

class FlashcardQuestion: UIView {

    private var flashcard: Flashcard
    private var flashcardFrame: CGRect
    
    private let wordLabel = UILabel()
    private let pronunciationLabel = UILabel()
    
    init(flashcard: Flashcard, frame: CGRect) {
        self.flashcard = flashcard
        self.flashcardFrame = frame
        super.init(frame: frame)

        backgroundColor = Colors.FATGWhiteBlack
        self.layer.cornerRadius = 10
        
        addSubview(wordLabel)
        configureWordLabel()
        addSubview(pronunciationLabel)
        configurePronunciationLabel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureWordLabel() {
        wordLabel.text = flashcard.word
        wordLabel.textColor = Colors.FATGtext
        wordLabel.textAlignment = .center
        wordLabel.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        wordLabel.numberOfLines = 0
        wordLabel.frame.size.height = (flashcard.word!.count < 21) ? ( 30 ) : ( 60 )
        
        wordLabel.frame = CGRect(x: 20,
                                 y: flashcardFrame.size.height / 2 - wordLabel.frame.size.height / 2 - 10,
                                 width: flashcardFrame.size.width - 40, //tak, żeby były paddingi po 20 z każdej strony
                                 height: wordLabel.frame.size.height)
        
        
        
    }
    
    private func configurePronunciationLabel() {
        pronunciationLabel.text = "/\(flashcard.pronunciation!)/"
        pronunciationLabel.textColor = Colors.FATGtext
        pronunciationLabel.textAlignment = .center
        pronunciationLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        pronunciationLabel.numberOfLines = 0
        pronunciationLabel.frame.size.height = 25
        
        pronunciationLabel.frame = CGRect(x: 20,
                                 y: flashcardFrame.size.height / 2 - pronunciationLabel.frame.size.height / 2 + 20 ,
                                 width: flashcardFrame.size.width - 40, //tak, żeby były paddingi po 20 z każdej strony
                                 height: wordLabel.frame.size.height)
        
    }

    
    
}

class correctWrongButton : UIButton {
    enum answerType {
        case correct
        case wrong
    }
    
    let type: answerType
    
    
    init(type: answerType, frame: CGRect){
        self.type = type
        super.init(frame: frame)
        self.contentHorizontalAlignment = .fill
        self.contentVerticalAlignment = .fill
        self.imageView?.contentMode = .scaleAspectFit
        
        switch type {
        case .correct:
            self.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            self.tintColor = Colors.FATGpurple
        case .wrong:
            self.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
            self.tintColor = Colors.FATGpink
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
