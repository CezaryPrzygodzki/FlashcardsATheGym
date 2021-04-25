//
//  DataHelper.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 05/04/2021.
//

import Foundation
import UIKit
import CoreData

class DataHelper {
    
    static let shareInstance = DataHelper()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func saveContext(){
        do {
            try context.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func saveData(word: String, translation: String, pronunciation: String, meaning: String, example: String, lessons: [Lesson] ) ->Flashcard {
     
        let flashcard = Flashcard(context: context)
        flashcard.word = word
        flashcard.translation = translation
        flashcard.pronunciation = pronunciation
        flashcard.meaning = meaning
        flashcard.example = example
        for lesson in lessons {
            flashcard.addToLesson(lesson)
        }
        
        saveContext()
        
        return flashcard
        
    }
    func saveData(name: String) -> Lesson {
        let lesson = Lesson(context: context)
        
        lesson.name = name
        
        saveContext()
        
        return lesson
    }
    func editData(flashcardToEdit: Flashcard, word: String, translation: String, pronunciation: String, meaning: String, example: String, lessons: [Lesson] ) ->Flashcard {
        
        
        flashcardToEdit.word = word
        flashcardToEdit.translation = translation
        flashcardToEdit.pronunciation = pronunciation
        flashcardToEdit.meaning = meaning
        flashcardToEdit.example = example

        let lessonsToRemove : [Lesson] = loadData()
        for lesson in lessonsToRemove {
            if ((flashcardToEdit.lesson?.contains(lesson)) != nil) {
                flashcardToEdit.removeFromLesson(lesson)
            }
        }
        for lesson in lessons {
            flashcardToEdit.addToLesson(lesson)
        }
        saveContext()
        
        return flashcardToEdit
        
    }
    
    func editData(lessonToEdit: Lesson, newName: String) -> Lesson {
        
        lessonToEdit.name = newName
        
        saveContext()
        
        return lessonToEdit
    }
    
    func loadData<T: NSManagedObject>() ->[T]{
        var objects: [T] = [] // list od loaded objects
                
        do {
            objects = try context.fetch(T.fetchRequest() as! NSFetchRequest<T>)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        return objects
    }

    func loadFlashcards(lesson: Lesson) ->[Flashcard]{
        var allFlashcards: [Flashcard] = loadData()
        var flashcards: [Flashcard] = []
        
        for flashcard in allFlashcards {
            if (lesson.flashcards?.contains(flashcard) ?? false) {
                flashcards.append(flashcard)
            }
        }
        return flashcards
    }
    func deleteData<T: NSManagedObject>(object: T){
        context.delete(object)
        
        saveContext()
    }
    
    
//    func loadData() -> [Flashcard] {
//        var flashcards: [Flashcard] = []//List of loaded flashcards
//
//        do {
//            flashcards = try context.fetch(Flashcard.fetchRequest())
//        } catch let error as NSError {
//          print("Could not fetch. \(error), \(error.userInfo)")
//        }
//        return flashcards
//    }
//
//    func loadData() -> [Lesson]{
//        var lessons: [Lesson] = []
//
//        do {
//            lessons = try context.fetch(Lesson.fetchRequest())
//        } catch let error as NSError {
//          print("Could not fetch. \(error), \(error.userInfo)")
//        }
//
//        return lessons
//    }
    
    
    
//    func deleteData(flashcard: Flashcard) {
//
//        context.delete(flashcard)
//
//        do {
//            try context.save()
//        } catch let error as NSError {
//          print("Could not save. \(error), \(error.userInfo)")
//        }
//
//    }
//    func deleteData(lesson: Lesson){
//        context.delete(lesson)
//
//        do {
//            try context.save()
//        } catch let error as NSError {
//          print("Could not save. \(error), \(error.userInfo)")
//        }
//
//    }
    
    
}
