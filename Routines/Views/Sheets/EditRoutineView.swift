//
//  EditRoutineView.swift
//  Routines
//
//  Created by Indy McGinnis on 10/28/22.
//

import SwiftUI
import CoreData

struct EditRoutineView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    let routine: Routine
    @State var title: String
    @State var startTime: Date
    @State var endTime: Date
    @State var category: Routine.Category
    let allCases = Routine.Category.allCases
    
    init(routine: Routine) {
        self.routine = routine
        self.title = routine.title
        self.startTime = routine.startTime
        self.endTime = routine.endTime
        self.category = routine.categorySelection
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
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
                updateRoutine(routineID: routine.id, routineTitle: self.title)
                dismiss()
            })
        }
    }
    
    func updateRoutine(routineID: UUID, routineTitle: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Routine")
        let predicate = NSPredicate(format: "id = '\(routineID)'")
        fetchRequest.predicate = predicate
        
        do {
            let object = try moc.fetch(fetchRequest)
            print(object)
            if object.count == 1 {
                let objectUpdate = object.first as! NSManagedObject
                objectUpdate.setValue(routineTitle, forKey: "title")
            }
            do {
                try moc.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }

}

//struct EditRoutineView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditRoutineView()
//    }
//}
