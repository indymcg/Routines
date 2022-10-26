//
//  IsCompletedView.swift
//  Routines
//
//  Created by Indy McGinnis on 10/25/22.
//

import SwiftUI

struct TaskRowView: View {
    var isTaskCompleted: Bool
    var taskName: String
    
    var body: some View {
        HStack {
            Image(systemName: isTaskCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(Color("TagColor"))
                .font(.title)
            Text(taskName)
            Spacer()
        }
        .frame(width: 350)
        Divider()
        .frame(width: 350)
    }
}

struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TaskRowView(isTaskCompleted: false, taskName: "some task")
            TaskRowView(isTaskCompleted: true, taskName: "some task")
            TaskRowView(isTaskCompleted: false, taskName: "some task")
            TaskRowView(isTaskCompleted: false, taskName: "some task")
            TaskRowView(isTaskCompleted: false, taskName: "some task")
            TaskRowView(isTaskCompleted: false, taskName: "some task")
        }
        
    }
}
