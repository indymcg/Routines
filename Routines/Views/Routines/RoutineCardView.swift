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
    let startTime: Date
    let endTime: Date
    let progress: Double
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(.white)
                        .shadow(color: .gray, radius: 1.0)
                    VStack(alignment: .leading, spacing: 5) {
                        TitleView(routineName: routineName)
                        BodyView(categoryName: categoryName, startTime: startTime, endTime: endTime, progress: progress)
                            }
                        .padding()
                        }
            .frame(width: geo.size.width, height: 150)
            }
        .padding()
        }
    }

struct RoutineCardView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineCardView(routineName: "My Routine", categoryName: "Self Care", startTime: Date.now, endTime: Date.now, progress: 0.25)
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
            
            Button {
                print("edit/delete")
            } label: {
                EditButton()
            }
        }
    }
}

struct BodyView: View {
    let categoryName: String
    let startTime: Date
    let endTime: Date
    let progress: Double
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 5) {
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
                    Text(startTime, style: .time)
                        .foregroundColor(.gray)
                    Text("-")
                    Text(endTime, style: .time)
                        .foregroundColor(.gray)
                }
            }
            ProgressBarView(progress: progress)
                .offset(x: 180, y: -10)
        }
    }
}

struct ProgressBarView: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 3)
                .foregroundColor(.gray)
                .frame(width: 70, height: 70)
            
             Circle()
                 .trim(from: 0, to: progress)
                 .stroke(lineWidth: 3)
                 .foregroundColor(.green)
                 .frame(width: 70, height: 70)
                 .rotationEffect(.degrees(-90))
                 .animation(.easeOut, value: progress)
            
            Text(String(format: "%.0f", progress * 100) + "%")
                .font(.subheadline)
         }
    }
}
