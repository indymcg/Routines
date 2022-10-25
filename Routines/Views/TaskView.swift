//
//  TasksView.swift
//  Routines
//
//  Created by Indy McGinnis on 10/25/22.
//

import SwiftUI

struct TaskView: View {
    @State var showingCompletedSheet = false
    @Environment(\.managedObjectContext) var moc
    let task: Task
    let name: String
    @State var isCompleted: Bool = false
    let associatedRoutine: Routine
    
    init(task: Task) {
        self.task = task
        self.name = task.wrappedName
        self.isCompleted = task.isCompleted
        self.associatedRoutine = task.associatedRoutine
    }
    
    var body: some View {
        HStack {
                Button {
                    self.task.isCompleted = true
                    isCompleted = true
                    associatedRoutine.determineRoutineCompletion()
                        if associatedRoutine.allTasksCompleted {
                            showingCompletedSheet = true
                            associatedRoutine.resetTaskCompletion()
                        }
                        do {
                            try moc.save()
                        } catch {
                            print("failed to save completed status \(error)")
                        }
                    } label: {
                        TaskRowView(isTaskCompleted: isCompleted, taskName: name)
                            .foregroundColor(.black)
                    }
                }
                .sheet(isPresented: $showingCompletedSheet) {
                    CompletedRoutineView(routine: self.associatedRoutine)
                }
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
