//
//  AddListViewController.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 16/02/2021.
//

import UIKit

class AddListView: UIView {

    //Dimensions
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    var padding : CGFloat = 20
    var addListWidth = UIScreen.main.bounds.size.width - 100
    var addListHeight = UIScreen.main.bounds.size.height - 300
    
    let label = UILabel()
    let textFieldName = UITextField()
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Colors.FATGpurple
        layer.cornerRadius = 10
        
        self.frame.size.height = 200
        self.frame.size.width = screenWidth - 100
        
        configureLabel()
        addSubview(label)
        
        configureTextFieldName()
        addSubview(textFieldName)

        configureButton()
        addSubview(button)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLabel() {
        
        label.textColor = Colors.FATGtext
        label.frame.size.width = screenWidth - 100 - CGFloat((padding*2))
        label.frame.size.height = 40
        
        label.text = "Podaj nazwę listy:"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        label.frame = CGRect(x: CGFloat(padding),
                             y: CGFloat(padding),
                             width: label.frame.size.width,
                             height: label.frame.size.height)
        
        
    }

    func configureTextFieldName() {
        
        textFieldName.textField(placeholder: "nazwa listy")
        textFieldName.frame.size.width = addListWidth - ( padding * 2 )
        textFieldName.frame = CGRect(x: CGFloat(padding),
                                     y: label.frame.origin.y + label.frame.size.height,
                                     width: textFieldName.frame.size.width,
                                     height: textFieldName.frame.size.height)
        
    }
    func configureButton() {
        button.setTitle("Dodaj", for: .normal)
        button.setTitleColor(Colors.FATGpurple, for: .normal)
        button.backgroundColor = Colors.FATGWhiteBlack
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 10
        
        button.frame.size.width = 100
        button.frame.size.height = 50
        
        button.frame = CGRect(x: self.frame.size.width / 2 - button.frame.size.width / 2,
                              y: textFieldName.frame.origin.y + textFieldName.frame.size.height + padding,
                              width: button.frame.size.width,
                              height: button.frame.size.height)
        
        button.addTarget(self, action: #selector(addList), for: .touchUpInside)
    }
    
    @objc func addList(sender:  UIButton!){
        
        let name = textFieldName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if ( name == "" ){
            Alert.wrongData(on: UIViewController(), message: "Uzupełnij pole nazwa.")
        } else {
            let lesson = DataHelper.shareInstance.saveData(name: name)
            NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
            NotificationCenter.default.post(name: Notification.Name("hideBlur"), object: nil)
            
        }
        
        print("Nice, dodałeś kolejną listę byczq")
        
        
    }
}
