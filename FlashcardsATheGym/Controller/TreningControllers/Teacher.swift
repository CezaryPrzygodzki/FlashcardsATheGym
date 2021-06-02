//
//  Teacher.swift
//  FlashcardsATheGym
//
//  Created by Cezary Przygodzki on 01/05/2021.
//

import Foundation

protocol Teach {
    var lesson: Lesson? { get }
    var listOfFlashcards: [Flashcard] { get }
    func correctAnswer() -> Flashcard?
    func wrongAnswer() -> Flashcard?
}
class Teacher: Teach {
    
    let lesson: Lesson?
    var listOfFlashcards: [Flashcard]
    private var correctAnswers: UInt
    private var wrongAnswers: UInt
    
    init(lesson: Lesson? , flashcards: [Flashcard]){
        self.lesson = lesson
        self.listOfFlashcards = flashcards
        self.correctAnswers = 0
        self.wrongAnswers = 0
    }
    
    
    func wrongAnswer() -> Flashcard? {
        wrongAnswers += 1
        
        if let f = listOfFlashcards.first {
            listOfFlashcards.append(f)//dodajemy na koniec, by w tej samej lekcji jeszcze raz przerobić słówko
            listOfFlashcards.removeFirst()
            return f
        }
        return nil
    }
    
    func correctAnswer() -> Flashcard? {
        correctAnswers += 1

        if let f = listOfFlashcards.first {
            listOfFlashcards.removeFirst()
        
            return f
        }
        return nil
    }
    
    func showPoints() {
        print("Correct answers: \(correctAnswers) Wrong answers: \(wrongAnswers)")
    }
}
