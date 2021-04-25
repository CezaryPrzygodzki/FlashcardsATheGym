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
    
    let textFieldName = UITextField()
    let saveButton = UIButton()
    let cancelButton = UIButton()
    
    lazy var buttonsStackView = UIStackView()
    var lessonToEdit: Lesson!

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        contentView.addSubview(background)
        configureBackground()
        background.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7.5).isActive = true
        background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        background.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7.5).isActive = true
        
        background.addSubview(nameOfListOfFlashcardsLabel)
        configureNameOfListOfFlashcardsLabel()
        nameOfListOfFlashcardsLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 17.5).isActive = true
        nameOfListOfFlashcardsLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 20).isActive = true
        nameOfListOfFlashcardsLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -20).isActive = true
        nameOfListOfFlashcardsLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        background.addSubview(textFieldName)
        configureTextFieldName()
        textFieldName.topAnchor.constraint(equalTo: nameOfListOfFlashcardsLabel.bottomAnchor, constant: 25).isActive = true
        textFieldName.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 20).isActive = true
        textFieldName.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -20).isActive = true
        textFieldName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        configureSaveButton()
        configureCancelButton()

        buttonsStackView = configureButtonsStackView()
        background.addSubview(buttonsStackView)
        
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 25).isActive = true
        buttonsStackView.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 50).isActive = true
        buttonsStackView.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -50).isActive = true
        buttonsStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true

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
    
    func configureNameOfListOfFlashcardsLabel(){
        nameOfListOfFlashcardsLabel.text = "Czasowniki nieregularne"
        nameOfListOfFlashcardsLabel.textColor = Colors.FATGtext
        nameOfListOfFlashcardsLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)

        
        nameOfListOfFlashcardsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    func configureTextFieldName(){
        textFieldName.placeholder = "Nowa nazwa lekcji"
        textFieldName.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        textFieldName.addPadding(.both(20))
        textFieldName.layer.cornerRadius = 10
        textFieldName.backgroundColor = Colors.FATGbackground
        textFieldName.textColor = Colors.FATGtext
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureSaveButton(){
        saveButton.setTitle("Zapisz", for: UIControl.State.normal)
        saveButton.setTitleColor(Colors.FATGWhiteBlack, for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        saveButton.backgroundColor = Colors.FATGtext
        saveButton.layer.cornerRadius = 10
        saveButton.addTarget(self, action: #selector(saveName), for: .touchUpInside)
        
    }
    @objc func saveName(sender: UIButton!){
        let name = textFieldName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if ( name == "" ) {

            
        } else {
            
            lessonToEdit = DataHelper.shareInstance.editData(lessonToEdit: lessonToEdit, newName: name)
            nameOfListOfFlashcardsLabel.text = name
        }
        print("Saved successfully")
        NotificationCenter.default.post(name: Notification.Name("cancel"), object: nil)
    }
    
    func configureCancelButton(){
        cancelButton.setTitle("Anuluj", for: UIControl.State.normal)
        cancelButton.setTitleColor(Colors.FATGWhiteBlack, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        cancelButton.backgroundColor = Colors.FATGtext
        cancelButton.layer.cornerRadius = 10
        cancelButton.addTarget(self, action: #selector(cancelButtonFunc), for: .touchUpInside)
        
    }
    @objc func cancelButtonFunc(sender: UIButton!){
        NotificationCenter.default.post(name: Notification.Name("cancel"), object: nil)
        print("Cancel")
    }
    
    func configureButtonsStackView() -> UIStackView {
        
        let sv = UIStackView(arrangedSubviews: [saveButton,cancelButton])
        
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 25
        
        return sv
    }
}
