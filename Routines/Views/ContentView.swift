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
                            Text(routine.wrappedTitle)
                            Spacer()
                            Text(routine.dueDate, style: .time)
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("Routines")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("New Routine") {
                        showingSheet.toggle()
                    }
                    .sheet(isPresented: $showingSheet) { NewRoutineView()
                    }
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
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $text)
                    DatePicker("Complete by:", selection: $dueDate, displayedComponents: .hourAndMinute)
                }
            }
            .navigationTitle("New Routine")
            .navigationBarItems(trailing:
            Button("Save") {
                if !self.text.isEmpty {
                    Routine.createWith(title: self.text, dueDate: self.dueDate, in: moc)
                    dismiss()
                }
            })
        }
    }
}
