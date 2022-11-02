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
    @FetchRequest(entity: Routine.entity(), sortDescriptors: [])
    var routines: FetchedResults<Routine>
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                ScrollView(.vertical) {
                    HStack {
                        HomePageTitle()
                        
                        Button {
                            print("show sheet")
                            showingSheet.toggle()
                        } label: {
                            AddButton()
                                .padding()
                        }
                    }
                    .sheet(isPresented: $showingSheet) {
                        NewRoutineView()
                    }
                    
                    ForEach(routines) { routine in
                        NavigationLink {
                            SingleRoutineView(routine: routine)
                        } label:{
                            RoutineCardView(routine: routine)
                                .padding(.bottom, 110)
                            }
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


struct HomePageTitle: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Today")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text(Date.now, style: .date)
                    .font(.title)
                    .fontWeight(.semibold)
            }
            .padding()
            Spacer()
        }
    }
}
