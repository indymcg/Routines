//
//  RoutinesApp.swift
//  Routines
//
//  Created by Indy McGinnis on 10/19/22.
//

import SwiftUI

@main
struct RoutinesApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
