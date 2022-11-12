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
    @State var showDeletionAlert = false
    @ObservedObject var routine: Routine
    
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
                                
                                    Button {
                                        routine.resetRoutineProgress(routine: routine)
                                    } label: {
                                        Text("Reset")
                                    }
                                } label: {
                                    EditButton()
                                }
                            
                            
                                .onChange(of: routine.allTasksCompleted, perform: { _ in
                                    showCompletedView = true
                                })
                            
                            
                            .sheet(isPresented: $showAddTaskSheet) {
                                NewTaskView(routine: routine)
                            }
                            
                            .sheet(isPresented: $showCompletedView) {
                                    RoutineCompleteView()
                            }
                            
                            .alert(isPresented: $showDeletionAlert) {
                                Alert(title: Text("Oops!"), message: Text("Completed tasks cannot be deleted."), dismissButton: .default(Text("OK")))
                            }
                        }
 
                    List {
                        ForEach(routine.associatedTasks) { task in
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
            let task = routine.associatedTasks[index]
            if !task.isCompleted {
                moc.delete(task)
            } else {
                showDeletionAlert = true
                print("cannot delete")
            }
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
