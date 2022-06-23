//
//  ListDetailView.swift
//  Habits
//
//  Created by Thomas Schatton on 03.05.22.
//

import SwiftUI

struct ListDetailView: View {
    @ObservedObject private var habits: Activities
    
    @State private var activityCompletions: Int
    
    private let id: UUID
    private var activityName: String
    private let activityDescription: String
    
    init(habits: Activities, activity: Activity) {
        self.habits = habits

        _activityCompletions = State(initialValue: activity.completions)
        
        self.id = activity.id
        self.activityName = activity.name
        self.activityDescription = activity.description
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(activityName)")
                .font(.headline.weight(.semibold))
                .foregroundColor(.black)
                .padding(.horizontal, 10)
            
            HStack {
                Text("Completions \(activityCompletions)")
                    .font(.headline.weight(.light))
                    .foregroundColor(.black)
                
                Spacer()
                
                Button("Add One") {
                    activityCompletions += 1
                    updateItem()
                }
                .padding(10)
                .background(.green)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            }
            .padding(.horizontal, 10)
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
    
    func updateItem() {
        guard let index = habits.activities.firstIndex(where: { $0.id == id }) else {
            print("Could not find index.")
            return
        }
        
        let updatedActivity = Activity(id: id, name: activityName, description: activityDescription, completions: activityCompletions)
        
        habits.activities[index] = updatedActivity
    }
}

struct ListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ListDetailView(habits: Activities(), activity: Activity(name: "Test1 Title", description: "Test 1 desc"))
    }
}
