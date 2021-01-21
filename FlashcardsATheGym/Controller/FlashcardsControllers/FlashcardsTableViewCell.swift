//
//  FlashcardsTableViewCell.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 21/01/2021.
//

import UIKit

class FlashcardsTableViewCell: UITableViewCell {

    let cellWidth = UIScreen.main.bounds.size.width - 50
    let cellHeight : CGFloat = 100
    let padding: CGFloat = 15
    
    
    let background = UIView()
    let wordLabel = UILabel()
    let translationLabel = UILabel()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        addSubview(background)
        configureBackground()
        
        addSubview(wordLabel)
        configureWordLabel()
        
        addSubview(translationLabel)
        configureTranslationLabel()
        

     }
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

    
    
    func configureBackground() {
        background.backgroundColor = Colors.FATGWhiteBlack
        
        background.layer.cornerRadius = 10

        background.frame.size.height = cellHeight - 20
        background.frame.size.width = cellWidth
        
    }
    
    func configureWordLabel(){
        wordLabel.text = "Sensational"
        wordLabel.textColor = Colors.FATGtext
        wordLabel.font = UIFont.systemFont(ofSize: 19, weight: .medium)

        
        wordLabel.frame.size.width = cellWidth - padding - padding
        wordLabel.frame.size.height = 30
        
        wordLabel.frame = CGRect(x: padding,
                                 y: background.frame.size.height / 2 - wordLabel.frame.size.height / 2 - 10,
                                 width: wordLabel.frame.size.width,
                                 height: wordLabel.frame.size.height)
        
        
    }
    func configureTranslationLabel() {
        translationLabel.text = "Rewelacyjny"
        translationLabel.textColor = Colors.FATGtext
        translationLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)

        
        translationLabel.frame.size.width = cellWidth - padding - padding
        translationLabel.frame.size.height = 30
        
        translationLabel.frame = CGRect(x: padding,
                                 y: background.frame.size.height / 2 - translationLabel.frame.size.height / 2 + 10,
                                 width: translationLabel.frame.size.width,
                                 height: translationLabel.frame.size.height)
    }

}
