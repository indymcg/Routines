//
//  RoutinesApp.swift
//  Routines
//
//  Created by Indy McGinnis on 10/19/22.
//

import SwiftUI

@main
struct RoutinesApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
