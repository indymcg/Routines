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
    var routine: Routine
    
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
                        self.startTime = routine.wrappedStartTime
                        self.endTime = routine.wrappedEndTime
                        self.category = routine.categorySelection
                    }
                }
                .navigationTitle("Edit Routine")
                .navigationBarItems(trailing:
                Button("Save") {
                    Routine.updateRoutine(routine: self.routine, title: text, startTime: startTime, endTime: endTime, categorySelection: category, categoryValue: category.rawValue, in: moc)
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
