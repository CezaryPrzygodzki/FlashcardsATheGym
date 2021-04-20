//
//  LessonsTableViewCell.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 11/04/2021.
//

import UIKit
import BEMCheckBox

class LessonsTableViewCell: UITableViewCell {

    let cellWidth = UIScreen.main.bounds.size.width - 50
    let cellHeight : CGFloat = 60
    let padding: CGFloat = 15

    let background = UIView()
    let nameOfListOfFlashcardsLabel = UILabel()
    
    let checkButton = BEMCheckBox()
    var checkButtonPressed : (() -> ()) = {}
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        
        contentView.addSubview(checkButton)
        configureCheckButton()
        
        contentView.addSubview(background)
        configureBackground()
        
        background.addSubview(nameOfListOfFlashcardsLabel)
        configureNameOfListOfFlashcardsLabel()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureBackground() {
        background.backgroundColor = Colors.FATGWhiteBlack
        background.layer.cornerRadius = 10
        background.clipsToBounds = true
        
        background.translatesAutoresizingMaskIntoConstraints = false
        background.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        background.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: 10).isActive = true
        background.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
    }
    
    func configureCheckButton() {
        checkButton.frame = CGRect(x: 10, y: 10, width: 30, height: 30)
        
        checkButton.lineWidth = 4.0
        checkButton.tintColor = Colors.FATGWhiteBlack! //The color of the box when the checkbox is Off.
        checkButton.onCheckColor = Colors.FATGpurple! //The color of the check mark when it is On.
        checkButton.onTintColor = Colors.FATGpurple! //The color of the line around the box when it is On.

        checkButton.delegate = self
    }
    
    func configureNameOfListOfFlashcardsLabel(){
        nameOfListOfFlashcardsLabel.text = "Nazwa lekcji"
        nameOfListOfFlashcardsLabel.textColor = Colors.FATGtext
        nameOfListOfFlashcardsLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        nameOfListOfFlashcardsLabel.translatesAutoresizingMaskIntoConstraints = false
        nameOfListOfFlashcardsLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 5).isActive = true
        nameOfListOfFlashcardsLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 15).isActive = true
        nameOfListOfFlashcardsLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -5).isActive = true
        nameOfListOfFlashcardsLabel.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -5).isActive = true
    }

}

extension LessonsTableViewCell: BEMCheckBoxDelegate {
    
    func didTap(_ checkBox: BEMCheckBox) {
        checkButtonPressed()
    }
}
