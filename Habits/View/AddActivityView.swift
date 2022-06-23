//
//  AddActivityView.swift
//  Habits
//
//  Created by Thomas Schatton on 02.05.22.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var habits: Activities
    
    @State private var activityName: String = ""
    @State private var activityDescription: String = ""
    @State private var missingUserInput = false
    
    let placeholder = "Acitivity description"
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Activity name", text: $activityName)
                    .padding(Edge.Set.leading, 5)
                ZStack (alignment: .topLeading) {
                    if activityDescription.isEmpty {
                        Text(placeholder)
                            .foregroundColor(.gray)
                            .opacity(0.5)
                            .padding(Edge.Set.top, 8)
                            .padding(Edge.Set.leading, 5)
                    }
                    
                    TextEditor(text: $activityDescription)
                        .multilineTextAlignment(.leading)
                }
            }
            .navigationTitle("Add a new activity")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if activityName.isEmpty {
                            missingUserInput = true
                            return
                        }
                        let activity = Activity(name: activityName, description: activityDescription)
                        habits.activities.append(activity)
                        dismiss()
                    }
                }
            }
            .alert("Empty String", isPresented: $missingUserInput) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Activity name is missing.")
                    .fontWeight(.semibold)
            }
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(habits: Activities())
    }
}
