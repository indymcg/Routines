//
//  IsCompletedView.swift
//  Routines
//
//  Created by Indy McGinnis on 10/25/22.
//

import SwiftUI

struct TaskRowView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var task: Task
    @State var name: String = ""
    
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(Color("TagColor"))
                .font(.title)
            TextField("Task", text: $name)
        }
        .onAppear {
            self.name = task.wrappedName
        }
        .onChange(of: name, perform: { newValue in
            if !newValue.isEmpty {
                Task.updateTask(task: task, name: newValue, using: moc)
            }
        })
    }
}

