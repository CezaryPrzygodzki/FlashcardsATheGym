//
//  Flashcard+CoreDataProperties.swift
//  
//
//  Created by Cezary Przygodzki on 03/06/2021.
//
//

import Foundation
import CoreData


extension Flashcard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Flashcard> {
        return NSFetchRequest<Flashcard>(entityName: "Flashcard")
    }

    @NSManaged public var example: String?
    @NSManaged public var meaning: String?
    @NSManaged public var pronunciation: String?
    @NSManaged public var translation: String?
    @NSManaged public var word: String?
    @NSManaged public var lesson: NSSet?

}

// MARK: Generated accessors for lesson
extension Flashcard {

    @objc(addLessonObject:)
    @NSManaged public func addToLesson(_ value: Lesson)

    @objc(removeLessonObject:)
    @NSManaged public func removeFromLesson(_ value: Lesson)

    @objc(addLesson:)
    @NSManaged public func addToLesson(_ values: NSSet)

    @objc(removeLesson:)
    @NSManaged public func removeFromLesson(_ values: NSSet)

}
