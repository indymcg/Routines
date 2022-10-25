//
//  ContentView.swift
//  Routines
//
//  Created by Indy McGinnis on 10/19/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var showingSheet = false
    var routinesFetchRequest = Routine.sortedFetchRequest()
    var routines: FetchedResults<Routine> {
        routinesFetchRequest.wrappedValue
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                ForEach(routines) { routine in
                    NavigationLink {
                        SingleRoutineView(routine: routine)
                    } label:{
                        HStack {
                            Image(systemName: "circle")
                                .foregroundColor(routine.allTasksCompleted ? .green : .red)
                            Text(routine.wrappedTitle)
                            Spacer()
                            Text(routine.categorySelection.description)
                                HStack {
                                    Image(systemName: "clock.fill")
                                    Text(routine.dueDate, style: .time)
                                }
                            }
                        .padding()
                        }
                    }
                }
                
            }
            .navigationTitle("Routines")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        HStack {
                            Text("New Routine")
                            Image(systemName: "plus.circle")
                        }
                    }
                    .sheet(isPresented: $showingSheet) { NewRoutineView() }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct NewRoutineView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @State var text: String = ""
    @State var dueDate = Date()
    @State var category: Routine.Category = .selfCare
    let allCases = Routine.Category.allCases
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $text)
                    DatePicker("Date:", selection: $dueDate, displayedComponents: .date)
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
                    Routine.createWith(title: self.text, dueDate: self.dueDate, categorySelection: self.category, categoryValue: self.category.rawValue, in: moc)
                    dismiss()
                }
            })
        }
    }
}
