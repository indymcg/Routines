//
//  EditMenu.swift
//  Routines
//
//  Created by Indy McGinnis on 10/27/22.
//

import SwiftUI

struct EditMenu: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 150, height: 150)
                .foregroundColor(.white)
                .shadow(radius: 3)
            VStack(alignment: .leading) {
                MenuRow(text: "Edit", imageName: "pencil")
                    .foregroundColor(.gray)
                MenuRow(text: "Quick Add", imageName: "plus")
                    .foregroundColor(.gray)
                MenuRow(text: "Delete", imageName: "trash")
                    .foregroundColor(.red)
            }
        }
    }
}

struct EditMenu_Previews: PreviewProvider {
    static var previews: some View {
        EditMenu()
    }
}

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
