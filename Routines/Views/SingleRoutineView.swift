//
//  SingleRoutineView.swift
//  Routines
//
//  Created by Indy McGinnis on 10/19/22.
//

import SwiftUI
import CoreData

struct SingleRoutineView: View {
    @State var showingTaskSheet = false
    
        var routine: Routine
        var tasks: [Task]
    
        init(routine: Routine) {
            self.routine = routine
            self.tasks = routine.associatedTasks
        }

    var body: some View {
        List {
            ForEach(tasks) { task in
                TaskView(task: task)
            }
        }
        Button("New Task") {
            showingTaskSheet.toggle()
        }
        .sheet(isPresented: $showingTaskSheet) {
            NewTaskView(routine: self.routine)
        }
        .navigationTitle(routine.wrappedTitle)
    }
}

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
                        }
                        do {
                            try moc.save()
                        } catch {
                            print("failed to save completed status \(error)")
                        }
                    } label: {
                        TaskRowView(isTaskCompleted: isCompleted, taskName: name)
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

struct CompletedRoutineView: View {
    @Environment(\.dismiss) var dismiss
    let routine: Routine
    
    var body: some View {
        NavigationView {
            VStack {
                Text("You completed all tasks in your routine!")
                    .font(.title)
                
                Button {
                    routine.resetTaskCompletion()
                    dismiss()
                } label: {
                    Text("Reset Tasks")
                        .foregroundColor(.white)
                        .background(.blue)
                        .frame(width: 100, height: 80)
                }
                .padding()
            }
        }
    }
}
