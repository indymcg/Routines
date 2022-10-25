//
//  SingleRoutineView.swift
//  Routines
//
//  Created by Indy McGinnis on 10/19/22.
//

import SwiftUI
import CoreData

struct SingleRoutineView: View {
    @Environment(\.dismiss) var dismiss
    @State var showingTaskSheet = false
    
        var routine: Routine
        var tasks: [Task]
        var allRoutineTasksCompleted: Bool
    
        init(routine: Routine) {
            self.routine = routine
            self.tasks = routine.associatedTasks
            self.allRoutineTasksCompleted = routine.allTasksCompleted
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
                    Text("Dismiss")
                        .foregroundColor(.white)
                        .background(.blue)
                }
                .padding()
            }
        }
    }
}
