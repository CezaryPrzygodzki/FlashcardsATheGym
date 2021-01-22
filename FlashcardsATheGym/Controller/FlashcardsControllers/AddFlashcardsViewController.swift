//
//  AddFlashcardsViewController.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 20/01/2021.
//

import UIKit

class AddFlashcardsViewController: UIViewController {

    let padding: CGFloat = 10
    
    let littleBarView = UIView()
    
    let titleLabel = UILabel()
    let textFieldWord = UITextField()
    let textFieldTranslation = UITextField()
    let textFieldPronunciation = UITextField()
    let textFieldMeaning = UITextField()
    let textFieldExample = UITextField()
    
    let addButton = UIButton()
    
    var flashcardsViewController: FlashcardsViewController?
    var allFlashcardsViewController: AllFlashcardsViewController?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.FATGbackground
        
        configureLittleBarView()
        view.addSubview(littleBarView)
        
        configureTitleLabel()
        view.addSubview(titleLabel)
        
        createTextFieldWord()
        view.addSubview(textFieldWord)
        
        createTextFieldTranslation()
        view.addSubview(textFieldTranslation)
        
        createTextFieldPronunciation()
        view.addSubview(textFieldPronunciation)
        
        createTextFieldMeaning()
        view.addSubview(textFieldMeaning)
        
        createTextFieldExample()
        view.addSubview(textFieldExample)
        
        createAddButton()
        view.addSubview(addButton)
        
    }
    
    func configureLittleBarView(){
        littleBarView.backgroundColor = .lightGray
        littleBarView.layer.cornerRadius = 5
        littleBarView.frame.size.width = 100
        littleBarView.frame = CGRect(x: self.view.frame.size.width / 2 - littleBarView.frame.size.width / 2,
                                     y: 10,
                                     width: littleBarView.frame.size.width,
                                     height: 5)
    }
    func configureTitleLabel(){
        
        titleLabel.text = "Nowa fiszka"
        titleLabel.textColor = Colors.FATGtext
        titleLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        titleLabel.frame = CGRect(x: 25, y: 40, width: 400, height: 100)
        titleLabel.sizeToFit()

        
    }
    
    @objc
    func anuluj() {
        dismiss(animated: true, completion: nil)
    }


    
    func createTextFieldWord(){
        textFieldWord.textField(placeholder: "Wyraz np sensational")
        textFieldWord.frame = CGRect(x: self.view.frame.size.width / 2 - textFieldWord.frame.size.width / 2,
                                     y: titleLabel.frame.origin.y + titleLabel.frame.size.height + 20,
                                     width: textFieldWord.frame.size.width,
                                     height: textFieldWord.frame.size.height)
    }
    
    func createTextFieldTranslation(){
        textFieldTranslation.textField(placeholder: "Tłumaczenie np rewelacyjny")
        textFieldTranslation.frame = CGRect(x: self.view.frame.size.width / 2 - textFieldTranslation.frame.size.width / 2,
                                     y: textFieldWord.frame.origin.y + textFieldWord.frame.size.height + padding,
                                     width: textFieldTranslation.frame.size.width,
                                     height: textFieldTranslation.frame.size.height)
    }
    
    func createTextFieldPronunciation(){
        textFieldPronunciation.textField(placeholder: "Wymowa np sensejszynal")
        textFieldPronunciation.frame = CGRect(x: self.view.frame.size.width / 2 - textFieldPronunciation.frame.size.width / 2,
                                     y: textFieldTranslation.frame.origin.y + textFieldTranslation.frame.size.height + padding,
                                     width: textFieldPronunciation.frame.size.width,
                                     height: textFieldPronunciation.frame.size.height)
    }
    
    func createTextFieldMeaning(){
        textFieldMeaning.textField(placeholder: "Znaczenie np very good, exciting")
        textFieldMeaning.frame = CGRect(x: self.view.frame.size.width / 2 - textFieldMeaning.frame.size.width / 2,
                                     y: textFieldPronunciation.frame.origin.y + textFieldPronunciation.frame.size.height + padding,
                                     width: textFieldMeaning.frame.size.width,
                                     height: textFieldMeaning.frame.size.height)
    }
    
    func createTextFieldExample(){
        textFieldExample.textField(placeholder: "Użycie np You look sensational this evening!")
        textFieldExample.frame = CGRect(x: self.view.frame.size.width / 2 - textFieldExample.frame.size.width / 2,
                                     y: textFieldMeaning.frame.origin.y + textFieldMeaning.frame.size.height + padding,
                                     width: textFieldExample.frame.size.width,
                                     height: textFieldExample.frame.size.height)
    }
    
    
    func createAddButton() {
        addButton.setTitle("Dodaj", for: UIControl.State.normal)
        addButton.setTitleColor(Colors.FATGWhiteBlack, for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        addButton.frame.size.width = 100
        addButton.frame.size.height = 50
        
        addButton.frame = CGRect(x: self.view.frame.size.width/2 - addButton.frame.size.width/2,
                                 y: textFieldExample.frame.origin.y + textFieldExample.frame.size.height + CGFloat(padding),
                                          width: addButton.frame.size.width,
                                          height: addButton.frame.size.height)
        
        addButton.backgroundColor = Colors.FATGtext
        
        addButton.layer.cornerRadius = 10
        
        addButton.addTarget(self, action: #selector(addButtonFunc), for: .touchUpInside)
        
    }
    
    @objc func addButtonFunc(sender: UIButton!){
        
        print("Przycisk do dodawania")
        
        let word = textFieldWord.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let translation = textFieldTranslation.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pronunciation = textFieldPronunciation.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let meaning = textFieldMeaning.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let example = textFieldExample.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if ( word == "" ){
            Alert.wrongData(on: self, message: "Uzupełnij pole wyraz.")
        } else if ( translation == "" ){
            Alert.wrongData(on: self, message: "Uzupełnij pole tłumaczenie.")
        } else if ( word == "" ) && ( translation == "" ) {
            Alert.wrongData(on: self, message: "Uzupełnij pola nazwa oraz tłumaczenie.")
        } else {
            
            guard let appDelegate =
              UIApplication.shared.delegate as? AppDelegate else {
              return
            }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let flashcard = Flashcard(context: managedContext)
            flashcard.word = word
            flashcard.translation = translation
            flashcard.pronunciation = pronunciation
            flashcard.meaning = meaning
            flashcard.example = example
            
            do {
              try managedContext.save()
                print("Yes, u did it!")
            } catch let error as NSError {
              print("Could not save. \(error), \(error.userInfo)")
            }
            
            
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    
}
