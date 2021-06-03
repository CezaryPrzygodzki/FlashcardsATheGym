//
//  CorrectWrongButton.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 03/06/2021.
//

import Foundation
import UIKit


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

