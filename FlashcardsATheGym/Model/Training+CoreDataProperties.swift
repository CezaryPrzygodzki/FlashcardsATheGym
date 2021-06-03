//
//  Training+CoreDataProperties.swift
//  
//
//  Created by Cezary Przygodzki on 03/06/2021.
//
//

import Foundation
import CoreData


extension Training {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Training> {
        return NSFetchRequest<Training>(entityName: "Training")
    }

    @NSManaged public var start: Date?
    @NSManaged public var end: Date?
    @NSManaged public var duration: Int64
    @NSManaged public var learingDuration: Int64
    @NSManaged public var trainingDuration: Int64
    @NSManaged public var lessonName: String?
    @NSManaged public var finishedFlashcards: String?

}
