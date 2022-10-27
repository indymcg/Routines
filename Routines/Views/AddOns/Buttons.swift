//
//  AddButton.swift
//  Routines
//
//  Created by Indy McGinnis on 10/26/22.
//

import SwiftUI

struct AddButton: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color("TagColor"))
                .frame(width: 40)
                .shadow(radius: 2.0)
            
            Image(systemName: "plus")
                .font(.title3)
                .foregroundColor(.white)
        }        
    }
}

struct EditButton: View {
    var body: some View {
        Image(systemName: "ellipsis")
            .font(.title3)
            .foregroundColor(.gray)
            .padding(.trailing, 25)
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AddButton()
            EditButton()
        }
    }
}
