//
//  DataHelper.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 05/04/2021.
//

import Foundation
import  UIKit
import CoreData

class DataHelper {
    
    static let shareInstance = DataHelper()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveData(word: String, translation: String, pronunciation: String, meaning: String, example: String ) ->Flashcard {
     
        let flashcard = Flashcard(context: context)
        flashcard.word = word
        flashcard.translation = translation
        flashcard.pronunciation = pronunciation
        flashcard.meaning = meaning
        flashcard.example = example
        
        do {
          try context.save()
            print("Yes, u did it!")
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
        return flashcard
        
    }
    func editData(flashcardToEdit: Flashcard, word: String, translation: String, pronunciation: String, meaning: String, example: String ) ->Flashcard {
        
        
        flashcardToEdit.word = word
        flashcardToEdit.translation = translation
        flashcardToEdit.pronunciation = pronunciation
        flashcardToEdit.meaning = meaning
        flashcardToEdit.example = example
        
        do {
          try context.save()
            print("Yes, u did it!")
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
        return flashcardToEdit
        
    }
    
    func loadData() -> [Flashcard] {
        var flashcards: [Flashcard] = []//List of loaded flashcards
        
        do {
            flashcards = try context.fetch(Flashcard.fetchRequest())
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        return flashcards
    }
    func deleteData(flashcard: Flashcard) {
        
        context.delete(flashcard)

        do {
            try context.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }

        
    }
}
