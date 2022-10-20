//
//  ContentView.swift
//  Routines
//
//  Created by Indy McGinnis on 10/19/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false
    @FetchRequest(sortDescriptors: [])
    var routines: FetchedResults<Routine>
    
    var body: some View {
        NavigationView {
            VStack {
                ForEach(routines) { routine in
                    List {
                    NavigationLink {
                        SingleRoutineView()
                    } label:{
                            Text(routine.wrappedTitle)
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
