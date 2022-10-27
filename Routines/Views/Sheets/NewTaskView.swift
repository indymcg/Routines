//
//  NewTaskView.swift
//  Routines
//
//  Created by Indy McGinnis on 10/27/22.
//

import SwiftUI

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
