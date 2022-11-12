//
//  AllRoutinesView.swift
//  Routines
//
//  Created by Indy McGinnis on 10/25/22.
//

import SwiftUI

struct RoutineCardView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var routine: Routine
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(.white)
                        .shadow(color: .gray, radius: 1.0)
                    VStack(alignment: .leading, spacing: 5) {
                        TitleView(routine: routine)
                        BodyView(routine: routine)
                            }
                        .padding()
                        }
            .frame(width: geo.size.width, height: 150)
            }
        .padding()
        }
    }

struct TitleView: View {
    @ObservedObject var routine: Routine
    
    var body: some View {
        HStack {
            Text(routine.title)
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            RoutineEditMenu(routine: routine)

        }
    }
}

struct BodyView: View {
    @ObservedObject var routine: Routine
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 5) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 80, height: 25)
                        .foregroundColor(Color(getCategoryTagColor(categoryName: routine.categorySelection.description)))
                    Text(routine.categorySelection.description)
                        .font(.body)
                        .foregroundColor(.white)
                    }
                
                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundColor(.gray)
                    Text(routine.wrappedStartTime, style: .time)
                        .foregroundColor(.gray)
                    Text("-")
                    Text(routine.wrappedEndTime, style: .time)
                        .foregroundColor(.gray)
                }
            }
            ProgressBarView(progress: routine.progress)
                .offset(x: 180, y: 0)
        }
    }
    
    func getCategoryTagColor(categoryName for: String) -> String {
        switch routine.categorySelection.description {
        case "Self Care":
            return "SelfcareColor"
        case "Work":
            return "WorkColor"
        case "Chores":
            return "ChoresColor"
        case "School":
            return "SchoolColor"
        case "Other":
            return "TagColor"
        default:
            return "TagColor"
        }
    }
}

struct ProgressBarView: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 5)
                .foregroundColor(Color("GrayishColor"))
                .frame(width: 70, height: 70)
            
             Circle()
                 .trim(from: 0, to: progress)
                 .stroke(lineWidth: 5)
                 .foregroundColor(.green)
                 .frame(width: 70, height: 70)
                 .rotationEffect(.degrees(-90))
                 .animation(.easeOut, value: progress)
            
            Text(String(format: "%.0f", progress * 100) + "%")
                .font(.subheadline)
         }
    }
}
