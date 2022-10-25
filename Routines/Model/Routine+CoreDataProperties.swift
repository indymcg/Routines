//
//  Routine+CoreDataProperties.swift
//  Routines
//
//  Created by Indy McGinnis on 10/19/22.
//
//

import Foundation
import CoreData
import SwiftUI


extension Routine {
    static func createWith(title: String, dueDate: Date, in moc: NSManagedObjectContext) {
        let newRoutine = self.init(context: moc)
        newRoutine.title = title
        newRoutine.id = UUID()
        newRoutine.dueDate = dueDate
        
        do {
            try moc.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }


    @NSManaged public var title: String
    @NSManaged public var id: UUID
    @NSManaged public var dueDate: Date
    @NSManaged public var associatedTasks: [Task]
    
    public var wrappedTitle: String {
        title ?? "New Routine"
    }
    
    static func basicFetchRequest() -> FetchRequest<Routine> {
         return FetchRequest<Routine>(entity: Routine.entity(), sortDescriptors: [])
     }
     
     static func sortedFetchRequest() -> FetchRequest<Routine> {
         let mySortDescriptor = NSSortDescriptor(key: "dueDate", ascending: true)
         return FetchRequest<Routine>(entity: Routine.entity(), sortDescriptors: [mySortDescriptor])
     }

}

// MARK: Generated accessors for tasks
extension Routine {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

extension Routine : Identifiable {

}
