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
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 1.0)
                VStack(alignment: .leading, spacing: 30) {
                    TitleView(routineName: routineName)
                    BodyView(categoryName: categoryName, date: date)
                        }
                    .padding()
                    }
                .frame(width: 350, height: 150)
        }
    }

struct RoutineCardView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineCardView(routineName: "My Routine", categoryName: "Self Care", date: Date.now)
    }
}


struct ProgressBarView: View {
    var body: some View {
        ZStack {
             Circle()
                 .stroke(lineWidth: 2)
                 .foregroundColor(.green)
                 .frame(width: 60, height: 60)
                 
             Text("1/12")
                 .font(.body)
                 .kerning(1.0)
         }
    }
}

struct TitleView: View {
    let routineName: String
    
    var body: some View {
        HStack {
            Text(routineName)
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            Image(systemName: "arrow.forward")
                .foregroundColor(.black)
                .padding(.trailing, 25)
        }
    }
}

struct BodyView: View {
    let categoryName: String
    let date: Date
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 80, height: 25)
                        .foregroundColor(Color("TagColor"))
                    Text(categoryName)
                        .font(.body)
                        .foregroundColor(.white)
                    }
                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundColor(.orange)
                    Text(date, style: .date)
                        .foregroundColor(.gray)
                }
            }
            ProgressBarView()
                .offset(x: 200)
        }
    }
}
