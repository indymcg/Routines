//
//  Task+CoreDataProperties.swift
//  Routines
//
//  Created by Indy McGinnis on 10/19/22.
//
//

import Foundation
import CoreData
import SwiftUI


extension Task {
    static func createWith(name: String, inRoutine routine: Routine, using moc: NSManagedObjectContext) {
        let task = Task(context: moc)
        task.name = name
        task.id = UUID()
        task.isCompleted = false
        task.associatedRoutine = routine
        
        do {
            try moc.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    static func updateTask(task: Task, name: String, using moc: NSManagedObjectContext) {
        task.name = name
        
        do {
            if moc.hasChanges && !name.isEmpty {
                try moc.save()
            }
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var associatedRoutine: Routine
    
    public var wrappedName: String {
        name ?? "New task"
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }
}

extension Task: Identifiable {

}
