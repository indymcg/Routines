//
//  AllRoutinesView.swift
//  Routines
//
//  Created by Indy McGinnis on 10/25/22.
//

import SwiftUI

struct RoutineCardView: View {
    let routineName: String
    let categoryName: String
    let date: Date
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 1.0)
                VStack(alignment: .leading) {
                        HStack {
                            Text(routineName)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Spacer()
                        
                            Image(systemName: "arrow.forward")
                                .foregroundColor(.black)
                            }
                            .padding(.bottom)
                    
                            Text(categoryName)
                                .foregroundColor(.gray)
                        
                            HStack {
                                Image(systemName: "clock.fill")
                                Text(date, style: .date)
                            }
                        }
                    .padding()
                    }
                .frame(width: 350, height: 150)
            }
            
        }
    }

struct RoutineCardView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineCardView(routineName: "My Routine", categoryName: "Chores", date: Date.now)
    }
}


struct ProgressBarView: View {
    var body: some View {
        ZStack {
             Circle()
                 .stroke(lineWidth: 2)
                 .foregroundColor(.green)
                 .frame(width: 50, height: 50)
                 
             Text("1/6")
                 .font(.body)
         }
    }
}
