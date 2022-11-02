//
//  EditRoutineView.swift
//  Routines
//
//  Created by Indy McGinnis on 11/1/22.
//

import SwiftUI

struct EditRoutineView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @State var text: String = ""
    @State var startTime = Date()
    @State var endTime = Date()
    @State var category: Routine.Category = .selfCare
    let allCases = Routine.Category.allCases
    let routine: Routine
    
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
                    .onAppear {
                        self.text = routine.title
                        self.startTime = routine.startTime
                        self.endTime = routine.endTime
                        self.category = routine.categorySelection
                    }
                }
                .navigationTitle("New Routine")
                .navigationBarItems(trailing:
                Button("Save") {
                    Routine.updateRoutine(routine: routine, title: text, startTime: startTime, endTime: endTime, categorySelection: category, categoryValue: category.rawValue, in: moc)
                    dismiss()
                })
            }
    }
}

//struct EditRoutineView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditRoutineView()
//    }
//}