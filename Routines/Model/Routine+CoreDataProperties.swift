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
    static func createWith(title: String, dueDate: Date, categorySelection: Category, categoryValue: Int16, in moc: NSManagedObjectContext) {
        let newRoutine = self.init(context: moc)
        newRoutine.title = title
        newRoutine.id = UUID()
        newRoutine.dueDate = dueDate
        newRoutine.allTasksCompleted = false
        newRoutine.categoryValue = categoryValue
        newRoutine.categorySelection = categorySelection
        
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
    @NSManaged public var categoryValue: Int16
    var categorySelection: Category {
        get {
            return Category(rawValue: self.categoryValue)
        }
        set {
            self.categoryValue = newValue.rawValue
            print(categoryValue)
        }
    }
    
    
    public var wrappedTitle: String {
        title ?? "New Routine"
    }
    
    @objc public enum Category: Int16, CaseIterable {
       case selfCare = 0
       case work = 1
       case school = 2
       case chores = 3
       case other = 4
        
        public init(rawValue: Int16) {
            switch rawValue {
            case 0: self = .selfCare
            case 1: self = .work
            case 2: self = .school
            case 3: self = .chores
            case 4: self = .other
            default: self = .selfCare
            }
        }
        
        var description: String {
            switch self {
            case .selfCare: return "Self Care"
            case .work: return "Work"
            case .school: return "School"
            case .chores: return "Chores"
            case .other: return "Other"
            }
        }
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
        var currentTime = Date.now
        print("current time: \(currentTime)")
        print("dueDate: \(dueDate)")
        if currentTime == dueDate {
            allTasksCompleted = false 
            for task in associatedTasks {
                task.isCompleted = false
            }
        }
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
