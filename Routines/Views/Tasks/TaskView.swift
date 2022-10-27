//
//  TasksView.swift
//  Routines
//
//  Created by Indy McGinnis on 10/25/22.
//

import SwiftUI

struct TaskView: View {
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
        ZStack {
                HStack {
                        Button {
                            self.task.isCompleted = true
                            isCompleted = true
                            associatedRoutine.determineRoutineCompletion(in: moc)

                                do {
                                    try moc.save()
                                } catch {
                                    print("failed to save completed status \(error)")
                                }
                            } label: {
                                VStack {
                                    TaskRowView(isTaskCompleted: isCompleted, taskName: name)
                                        .foregroundColor(.black)
                            }
                        }
                        .disabled(isCompleted)
                    }
                }
        
            }
        }

