//
//  TasksView.swift
//  Routines
//
//  Created by Indy McGinnis on 10/25/22.
//

import SwiftUI

struct TaskView: View {
    @Environment(\.managedObjectContext) var moc
    var task: Task
    
    var body: some View {
        ZStack {
                HStack {
                        Button {
                            task.isCompleted = true
                            task.associatedRoutine.determineRoutineCompletion(in: moc)

                                do {
                                    try moc.save()
                                } catch {
                                    print("failed to save completed status \(error)")
                                }
                            } label: {
                                VStack {
                                    TaskRowView(task: task)
                                        .foregroundColor(.black)
                            }
                        }
                        .disabled(task.isCompleted)
                    }
                }
            }
        }

