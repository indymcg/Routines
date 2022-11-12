//
//  RoutineCompleteView.swift
//  Routines
//
//  Created by Indy McGinnis on 10/28/22.
//

import SwiftUI

struct RoutineCompleteView: View {
    
    var body: some View {
        VStack(spacing: 10) {
            
            Image(systemName: "checkmark.circle.fill")
                .font(.largeTitle)
                .foregroundColor(Color("TagColor"))
            
            Text("Great job!")
                .font(.title3)
                .kerning(1.0)
        }
    }
}

struct RoutineCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineCompleteView()
    }
}
