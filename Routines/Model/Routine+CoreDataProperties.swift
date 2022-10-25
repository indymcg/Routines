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
        newRoutine.allTasksCompleted = false
        
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
    @NSManaged public var allTasksCompleted: Bool
    
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
    
    func determineRoutineCompletion() {
        var counter = 0
        for task in associatedTasks {
            if task.isCompleted {
                counter += 1
            }
        }
        if counter == associatedTasks.count {
            allTasksCompleted = true
            print("all tasks complete")
        }
    }
    
    func resetTaskCompletion() {
        if allTasksCompleted {
            allTasksCompleted = false 
            for task in associatedTasks {
                task.isCompleted = false
            }
        }
        //else if that gets current time and comapres to dueDate to automatically reset task completion
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
