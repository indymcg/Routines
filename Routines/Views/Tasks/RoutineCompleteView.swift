//
//  RoutineCompleteView.swift
//  Routines
//
//  Created by Indy McGinnis on 10/28/22.
//

import SwiftUI

struct RoutineCompleteView: View {
    @State var animating = false
    
    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle.fill")
                .font(animating ? .largeTitle : .headline)
                .offset(y: -10)
                .foregroundColor(Color("TagColor"))
            
            Text("Great job!")
                .font(.title3)
                .kerning(1.0)
        }
        .animation(.spring(response: 1.0, blendDuration: 3.0), value: animating)
        .onAppear {
            animating.toggle()
        }
    }
}

struct RoutineCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineCompleteView()
    }
}
