//
//  Task+CoreDataProperties.swift
//  Routines
//
//  Created by Indy McGinnis on 10/19/22.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var routine: Routine
    
    public var wrappedName: String {
        name ?? "New task"
    }

}

extension Task: Identifiable {

}
