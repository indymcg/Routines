//
//  PersistenceController.swift
//  Routines
//
//  Created by Indy McGinnis on 10/19/22.
//

import CoreData

class PersistenceController: ObservableObject {
    let container: NSPersistentContainer
    static let shared = PersistenceController()

//    static var preview: PersistenceController = {
//      let result = PersistenceController(inMemory: true)
//      let viewContext = result.container.viewContext
//
//        do {
//          try viewContext.save()
//        } catch {
//          let nsError = error as NSError
//          fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//      }()
    
    init(inMemory: Bool = false) {
      container = NSPersistentContainer(name: "Routines")
        
      if inMemory {
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
      }
      container.loadPersistentStores { _, error in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      }
      container.viewContext.automaticallyMergesChangesFromParent = true

      container.viewContext.name = "viewContext"
      container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
      container.viewContext.undoManager = nil
      container.viewContext.shouldDeleteInaccessibleFaults = true
    }
  }
