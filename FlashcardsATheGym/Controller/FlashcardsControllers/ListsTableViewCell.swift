//
//  FlashcardsTableViewCell.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 17/01/2021.
//

import UIKit

class ListsTableViewCell: UITableViewCell {

    let cellWidth = UIScreen.main.bounds.size.width - 50
    let cellHeight : CGFloat = 80
    let padding: CGFloat = 15
    
    
    let background = UIView()
    let nameOfListOfFlashcardsLabel = UILabel()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        addSubview(background)
        configureBackground()
        
        addSubview(nameOfListOfFlashcardsLabel)
        configureNameOfListOfFlashcardsLabel()
        

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
    
    func configureNameOfListOfFlashcardsLabel(){
        nameOfListOfFlashcardsLabel.text = "Czasowniki nieregularne"
        nameOfListOfFlashcardsLabel.textColor = Colors.FATGtext
        nameOfListOfFlashcardsLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)

        
        nameOfListOfFlashcardsLabel.frame.size.width = cellWidth - padding - padding
        nameOfListOfFlashcardsLabel.frame.size.height = 30
        
        nameOfListOfFlashcardsLabel.frame = CGRect(x: padding,
                                                   y: background.frame.size.height / 2 - nameOfListOfFlashcardsLabel.frame.size.height / 2,
                                                   width: nameOfListOfFlashcardsLabel.frame.size.width,
                                                   height: nameOfListOfFlashcardsLabel.frame.size.height)
        
        
    }

}
