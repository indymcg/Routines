//
//  SingleRoutineView.swift
//  Routines
//
//  Created by Indy McGinnis on 10/19/22.
//

import SwiftUI
import CoreData

struct SingleRoutineView: View {
    @Environment(\.managedObjectContext) var moc
    @State var showingTaskSheet = false
    var routine: Routine
    var tasks: [Task]
    
    init(routine: Routine) {
        self.routine = routine
        self.tasks = routine.associatedTasks
    }
    
    
    var body: some View {
        VStack {
            List {
                ForEach(tasks) { task in
                    Button {
                       task.isCompleted = true
                        
                        do {
                            try moc.save()
                        } catch {
                            print("failed to save completed status \(error)")
                        }
                    } label: {
                        HStack {
                            Image(systemName: task.isCompleted ? "checkmark" : "circle")
                            Text(task.wrappedName)
                        }
                    }
                }
            }
            Button("New Task") {
                showingTaskSheet.toggle()
            }
            .sheet(isPresented: $showingTaskSheet) {
                NewTaskView(routine: self.routine)
            }
        }
        .navigationTitle(routine.wrappedTitle)
    }
}

struct NewTaskView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @State var name: String = ""
    let routine: Routine

    var body: some View {
        NavigationView {
            Form {
                TextField("name", text: $name)
            }
            .navigationTitle("New Task")
            .navigationBarItems(trailing:
                Button("Save") {
                if !self.name.isEmpty {
                    Task.createWith(name: self.name, inRoutine: self.routine, using: self.moc)
                    dismiss()
                }
            })
        }
    }
}
