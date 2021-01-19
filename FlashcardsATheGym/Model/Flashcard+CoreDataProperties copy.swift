//
//  Flashcard+CoreDataProperties.swift
//  
//
//  Created by Cezary Przygodzki on 19/01/2021.
//
//

import Foundation
import CoreData


extension Flashcard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Flashcard> {
        return NSFetchRequest<Flashcard>(entityName: "Flashcard")
    }

    @NSManaged public var word: String?
    @NSManaged public var translation: String?
    @NSManaged public var pronunciation: String?
    @NSManaged public var meaning: NSObject?
    @NSManaged public var example: NSObject?

}
