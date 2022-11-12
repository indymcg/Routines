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
    static func createWith(title: String, startTime: Date, endTime: Date, categorySelection: Category, categoryValue: Int16, in moc: NSManagedObjectContext) {
        let newRoutine = self.init(context: moc)
        newRoutine.title = title
        newRoutine.id = UUID()
        newRoutine.startTime = startTime
        newRoutine.endTime = endTime
        newRoutine.allTasksCompleted = false
        newRoutine.categoryValue = categoryValue
        newRoutine.progress = 0.0
        newRoutine.categorySelection = categorySelection
        
        do {
            try moc.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    static func updateRoutine(routine: Routine, title: String, startTime: Date, endTime: Date, categorySelection: Category, categoryValue: Int16, in moc: NSManagedObjectContext) {
        routine.title = title
        routine.id = routine.id
        routine.startTime = startTime
        routine.endTime = endTime
        routine.allTasksCompleted = routine.allTasksCompleted
        routine.categoryValue = categoryValue
        routine.progress = routine.progress
        routine.categorySelection = categorySelection
        routine.associatedTasks = routine.associatedTasks
        
        do {
            if moc.hasChanges {
                try moc.save()
            }
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
    }


    @NSManaged public var title: String
    @NSManaged public var id: UUID
    @NSManaged public var startTime: Date?
    @NSManaged public var endTime: Date?
    @NSManaged public var associatedTasks: [Task] 
    @NSManaged public var allTasksCompleted: Bool
    @NSManaged public var progress: Double
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
    
    var wrappedStartTime: Date {
        startTime ?? Date.now
    }
    
    var wrappedEndTime: Date {
        endTime ?? Date.now
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
         let mySortDescriptor = NSSortDescriptor(key: "startTime", ascending: true)
         return FetchRequest<Routine>(entity: Routine.entity(), sortDescriptors: [mySortDescriptor])
     }
    
    func resetRoutineProgress(routine: Routine) {
        if allTasksCompleted {
            print("reset")
            progress = 0.0
            allTasksCompleted = false 
            for task in associatedTasks {
                task.isCompleted = false
            }
        }
    }
    
    func getRoutineProgress() {
        var percentage = 1 / (Double(associatedTasks.count))
        for task in associatedTasks {
            if task.isCompleted {
                progress += percentage
                break
            }
        }
    }
    
    func determineRoutineCompletion(in moc: NSManagedObjectContext) {
        getRoutineProgress()
        
        if progress == 1 {
            allTasksCompleted = true
            print("all tasks complete: \(progress)")
        }
        
        do {
            try moc.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func deleteRoutine(routine: Routine, context: NSManagedObjectContext) {
        context.delete(routine)
        do {
            try context.save()
        } catch {
            print(error)
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
