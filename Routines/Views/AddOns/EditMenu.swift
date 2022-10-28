//
//  EditMenu.swift
//  Routines
//
//  Created by Indy McGinnis on 10/27/22.
//

import SwiftUI
import CoreData

struct EditMenu: View {
    @Environment(\.managedObjectContext) var moc
    let routine: Routine

    var body: some View {
    NavigationView {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 150, height: 150)
                .foregroundColor(.white)
                .shadow(radius: 3)
            
            VStack(alignment: .leading) {
                    Button {
                        print("edit")
                    } label: {
                        MenuRow(text: "Edit", imageName: "pencil")
                    }
                    
                    NavigationLink {
                        NewTaskView(routine: routine)
                    } label: {
                        MenuRow(text: "Quick add", imageName: "plus")
                    }
                    
                    Button {
                        print("delete")
                    } label: {
                        MenuRow(text: "Delete", imageName: "trash")
                    }
                }
            }
        }
    }
}

//struct EditMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        EditMenu(text: "fix", imageName: "folder", routine: <#Routine#>)
//    }
//}

struct MenuRow: View {
    let text: String
    let imageName: String
    var body: some View {
        HStack {
            Image(systemName: imageName)
            Text(text)
        }
        .padding(3)
    }
}
