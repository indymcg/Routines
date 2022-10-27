//
//  AddRoutineView.swift
//  Routines
//
//  Created by Indy McGinnis on 10/27/22.
//

import SwiftUI

struct NewRoutineView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @State var text: String = ""
    @State var startTime = Date()
    @State var endTime = Date()
    @State var category: Routine.Category = .selfCare
    let allCases = Routine.Category.allCases
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $text)
                    DatePicker("Start:", selection: $startTime, displayedComponents: .hourAndMinute)
                    DatePicker("End:", selection: $endTime, displayedComponents: .hourAndMinute)
                    Picker("Category:", selection: $category) {
                        ForEach(allCases, id: \.self) { value in
                            Text(value.description)
                        }
                    }
                    
                }
            }
            .navigationTitle("New Routine")
            .navigationBarItems(trailing:
            Button("Save") {
                if !self.text.isEmpty {
                    Routine.createWith(title: self.text, startTime: self.startTime, endTime: self.endTime, categorySelection: self.category, categoryValue: self.category.rawValue, in: moc)
                    dismiss()
                }
            })
        }
    }
}

