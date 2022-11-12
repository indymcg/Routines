//
//  EditMenu.swift
//  Routines
//
//  Created by Indy McGinnis on 10/27/22.
//

import SwiftUI
import CoreData

struct RoutineEditMenu: View {
    @Environment(\.managedObjectContext) var moc
    let routine: Routine
    @State var showEditSheet = false

    var body: some View {
            Menu {
                    Button {
                        showEditSheet = true
                    } label: {
                        Text("Edit")
                    }
                
                    Button {
                        routine.deleteRoutine(routine: routine, context: moc)
                    } label: {
                        Text("Delete")
                    }
                
                    Button {
                        routine.resetRoutineProgress(routine: routine)
                    } label: {
                        Text("Reset")
                    }
            } label: {
                EditButton()
            }
            .sheet(isPresented: $showEditSheet) {
                EditRoutineView(routine: routine)
            }
    }
}
