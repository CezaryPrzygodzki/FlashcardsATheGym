//
//  EditFlashcardsViewController.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 21/01/2021.
//

import UIKit

class EditFlashcardsViewController: AddFlashcardsViewController {


    var flashcardToEdit: Flashcard?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "Edytuj fiszkę"
        addButton.setTitle("Zapisz", for: .normal)
        titleLabel.frame.size.width = 600

        textFieldWord.text = flashcardToEdit!.word
        textFieldTranslation.text = flashcardToEdit!.translation
        textFieldPronunciation.text = flashcardToEdit?.pronunciation
        textFieldMeaning.text = flashcardToEdit?.meaning
        textFieldExample.text = flashcardToEdit?.example
        saveThisFlashcardInLessons = flashcardToEdit?.lesson?.allObjects as! [Lesson]

    }
    
    

    @objc override func addButtonFunc(sender: UIButton!){

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
            flashcardToEdit = DataHelper.shareInstance.editData(flashcardToEdit: flashcardToEdit!, word: word, translation: translation, pronunciation: pronunciation, meaning: meaning, example: example, lessons: saveThisFlashcardInLessons)
            allFlashcardsViewController?.loadData()
            allFlashcardsViewController?.flashcardsTableView.reloadData()
            
            dismiss(animated: true, completion: nil)
        }
        
    }

}
