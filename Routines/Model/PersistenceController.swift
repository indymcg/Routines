//
//  PersistenceController.swift
//  Routines
//
//  Created by Indy McGinnis on 10/19/22.
//

import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Routines")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("core data failed to laod \(error)")
            }
        }
    }
}
