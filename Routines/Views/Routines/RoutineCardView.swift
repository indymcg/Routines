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
                        BodyView(categoryName: routine.categorySelection.description, startTime: routine.startTime, endTime: routine.endTime, progress: routine.progress)
                            }
                        .padding()
                        }
            .frame(width: geo.size.width, height: 150)
            }
        .padding()
        }
    }

//struct RoutineCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoutineCardView(routineName: "My Routine", categoryName: "Work", startTime: Date.now, endTime: Date.now, progress: 0.25)
//    }
//}

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
                        .foregroundColor(Color(getCategoryTagColor(categoryName: categoryName)))
                    Text(categoryName)
                        .font(.body)
                        .foregroundColor(.white)
                    }
                
                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundColor(.gray)
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
    
    func getCategoryTagColor(categoryName for: String) -> String {
        switch categoryName {
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
