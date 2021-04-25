//
//  FlashcardsTableViewCell.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 21/01/2021.
//

import UIKit

class FlashcardsTableViewCell: UITableViewCell {

    let cellWidth = UIScreen.main.bounds.size.width - 50
    var cellHeight : CGFloat = 100
    let padding: CGFloat = 15
    
    
    let background = UIView()
    var wordLabel = UILabel()
    var translationLabel = UILabel()
    var pronunciationLabel = UILabel()
    var meaningLabel = UILabel()
    var exampleLabel = UILabel()
    
    lazy var stackView = UIStackView()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        contentView.addSubview(background)
        configureBackground()
        background.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        background.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
        background.addSubview(wordLabel)
        configureWordLabel()
        wordLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 15).isActive = true
        wordLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 20).isActive = true
        wordLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -20).isActive = true
        wordLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        background.addSubview(translationLabel)
        configureTranslationLabel()
        
        translationLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor).isActive = true
        translationLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 20).isActive = true
        translationLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -20).isActive = true
        translationLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //background.addSubview(pronunciationLabel)
        configurePronunciationLabel()

//        pronunciationLabel.topAnchor.constraint(equalTo: translationLabel.bottomAnchor).isActive = true
//        pronunciationLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 20).isActive = true
//        pronunciationLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -20).isActive = true
//        //pronunciationLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        //background.addSubview(meaningLabel)
        configureMeaningLabel()
//        meaningLabel.topAnchor.constraint(equalTo: pronunciationLabel.bottomAnchor, constant: 5 ).isActive = true
//        meaningLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 20).isActive = true
//        meaningLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -20).isActive = true
//        //meaningLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        //background.addSubview(exampleLabel)
        configureExampleLabel()
//        exampleLabel.topAnchor.constraint(equalTo: meaningLabel.bottomAnchor, constant: 5).isActive = true
//        exampleLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 20).isActive = true
//        exampleLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -20).isActive = true
//        exampleLabel.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -10).isActive = true
//        //exampleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        

        stackView = configureStackView()
        background.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: translationLabel.bottomAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -20).isActive = true
        


     }
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

    
    func animate(){
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn, animations:  {
            self.contentView.layoutIfNeeded()
        })

    }

    
    func configureBackground() {
        background.backgroundColor = Colors.FATGWhiteBlack
        
        background.layer.cornerRadius = 10

        background.clipsToBounds = true
        
        background.translatesAutoresizingMaskIntoConstraints = false
    }

    
    func configureWordLabel(){
        wordLabel.text = "Sensational"
        wordLabel.textColor = Colors.FATGtext
        wordLabel.font = UIFont.systemFont(ofSize: 19, weight: .medium)

        
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    func configureTranslationLabel() {
        translationLabel.text = "Rewelacyjny"
        translationLabel.textColor = Colors.FATGtext
        translationLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)

        
        translationLabel.translatesAutoresizingMaskIntoConstraints = false

    }
    func configurePronunciationLabel() {
        pronunciationLabel.text = "Sensenszynal"
        pronunciationLabel.textColor = Colors.FATGtext
        
        pronunciationLabel.font = UIFont.italicSystemFont(ofSize: 15)

        
        pronunciationLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureMeaningLabel(){
        
        meaningLabel.text = "Very happy, full of joy"
        meaningLabel.textColor = Colors.FATGtext
        meaningLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        meaningLabel.numberOfLines = 0

        
        meaningLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureExampleLabel(){
        exampleLabel.text = "You look sensational this evening"
        exampleLabel.textColor = Colors.FATGtext
        exampleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        exampleLabel.numberOfLines = 0

        
        exampleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configureStackView() -> UIStackView{
        
        let sv = UIStackView(arrangedSubviews: [pronunciationLabel, meaningLabel, exampleLabel])
        
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.spacing = 10
        
        return sv
    }
}
