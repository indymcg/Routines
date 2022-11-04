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
    @Environment(\.dismiss) var dismiss
    @State var showAddTaskSheet = false
    @State var showCompletedView = false
    
    var routine: Routine
    var tasks: [Task]
    
    init(routine: Routine) {
        self.routine = routine
        self.tasks = routine.associatedTasks
    }
    
    var body: some View {
        NavigationView {
                VStack {
                        HStack {
                            TasksHeaderView(routine: routine)
                            
                            Menu {
                                    Button {
                                        if !routine.allTasksCompleted {
                                            showAddTaskSheet = true
                                        } else {
                                            print("cannot add new tasks to completed routine")
                                        }
                                    } label: {
                                        Text("Add Task")
                                    }
                                    
                                    Button {
                                        routine.deleteRoutine(routine: routine, context: moc)
                                    } label: {
                                        Text("Delete Routine")
                                    }
                                } label: {
                                    EditButton()
                                }
                            
                            .sheet(isPresented: $showCompletedView) {
                                    RoutineCompleteView()
                                }
                            
                            .sheet(isPresented: $showAddTaskSheet) {
                                NewTaskView(routine: routine)
                            }
                        }
                    
                    List {
                        ForEach(tasks) { task in
                            TaskView(task: task)
                        }
                        .onDelete(perform: deleteTask)
                    }
                    .listStyle(.plain)
            }
            
        }

    }
    func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            let task = tasks[index]
            moc.delete(task)
            }
        
        do {
            try moc.save()
        } catch {
            print(error)
        }
    }
}


struct TasksHeaderView: View {
    let routine: Routine
    @State var showEditPopOver = false
    
    var body: some View {
            VStack(alignment: .leading) {
                Text(routine.title)
                    .font(.largeTitle)
                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundColor(.orange)
                    
                    HStack {
                        Text(routine.wrappedStartTime, style: .time)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("-")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(routine.wrappedEndTime, style: .time)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            Spacer()
    }
}
