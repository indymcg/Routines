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
    @State var showingEditPopOver = false
    
    var routine: Routine
    var tasks: [Task]
    var allRoutineTasksCompleted: Bool
    
    init(routine: Routine) {
        self.routine = routine
        self.tasks = routine.associatedTasks
        self.allRoutineTasksCompleted = routine.allTasksCompleted
    }
    
    var body: some View {
            VStack{
                    HStack {
                        TasksHeaderView(routine: routine)
                        
                        Button {
                            showingEditPopOver = true
                        } label: {
                            EditButton()
                        }
                        
                        .sheet(isPresented: $showingEditPopOver) {
                            EditMenu(routine: self.routine)
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
                Text(routine.wrappedTitle)
                    .font(.largeTitle)
                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundColor(.orange)
                    
                    HStack {
                        Text(routine.startTime, style: .time)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("-")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(routine.endTime, style: .time)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            Spacer()
    }
}
