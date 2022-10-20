//
//  NewRoutineView.swift
//  Routines
//
//  Created by Indy McGinnis on 10/20/22.
//

import SwiftUI

struct NewRoutineView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @State var text: String = ""
    
    var body: some View {
        VStack {
            Text("New Routine")
            Form {
                TextField("title", text: $text)
                }
            Button("Save") {
                if !self.text.isEmpty {
                    Routine.createWith(title: self.text, in: moc)
                    dismiss()
                }
            }
        }
    }
}

struct NewRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        NewRoutineView()
    }
}
