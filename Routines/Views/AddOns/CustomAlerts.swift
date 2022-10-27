//
//  CustomAlerts.swift
//  Routines
//
//  Created by Indy McGinnis on 10/27/22.
//

import SwiftUI

struct CompletedRoutineAlert: View {
    @Environment(\.managedObjectContext) var moc
    let routine: Routine

    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .shadow(radius: 5)
                    .foregroundColor(.white)
                    .frame(maxWidth: 350, maxHeight: 200)
                VStack(spacing: 5) {
                    Text("🎉🎉🎉")
                        .font(.title)
                        .kerning(4.0)
                        .shadow(radius: 2)
                    Text("Great job!")
                            .font(.title)
                            .fontWeight(.semibold)
                            .kerning(1.0)
                    Text("You completed all tasks in your routine.")
                            .font(.caption)
                            .fontWeight(.light)
                            .multilineTextAlignment(.center)

                    Button {
                        //routine.resetTaskCompletion(in: moc)
                    } label: {
                        Text("OK")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .kerning(0.5)
                            .padding(15)
                    }
                    .frame(width: 150)
                    .background(Color("TagColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 3)
                    }

                }
        }
    }

