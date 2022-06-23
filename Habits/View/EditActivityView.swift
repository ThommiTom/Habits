//
//  EditActivityView.swift
//  Habits
//
//  Created by Thomas Schatton on 02.05.22.
//

import SwiftUI

struct EditActivityView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject private var habits: Activities
    
    @State private var name: String
    @State private var descripton: String
    
    private let id: UUID
    private let completions: Int
    
    let placeholder = "Acitivity description"
    
    init(habits: Activities, activity: Activity) {
        self.habits = habits
        
        _name = State(initialValue: activity.name)
        _descripton = State(initialValue: activity.description)
        
        self.id = activity.id
        self.completions = activity.completions
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                List {
                    Section {
                        TextField("Activity name", text: $name)
                            .padding(Edge.Set.leading, 5)
                        
                        ZStack (alignment: .topLeading) {
                            if descripton.isEmpty {
                                Text(placeholder)
                                    .foregroundColor(.gray)
                                    .opacity(0.5)
                                    .padding(Edge.Set.top, 8)
                                    .padding(Edge.Set.leading, 5)
                            }
                            
                            TextEditor(text: $descripton)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    
                    Section {
                        HStack {
                            Text("Completions")
                            Spacer()
                            Text("\(completions)")
                        }
                    }
                }
                
                Button("Delete activity") {
                    deleteItem()
                }
                .padding(10)
                .background(.red)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    print("save button tapped")
                    updateItem()
                    dismiss()
                }
            }
        }
        
    }
    
    func updateItem() {
        guard let index = habits.activities.firstIndex(where: { $0.id == self.id }) else {
            print("Could not find index.")
            return
        }

        let updatedActivity = Activity(id: id, name: name, description: descripton, completions: completions)
        updatedActivity.printDetails()
        habits.activities[index] = updatedActivity
    }
    
    func deleteItem() {
        guard let index = habits.activities.firstIndex(where: { $0.id == self.id }) else {
            print("Could not find index.")
            return
        }
        
        habits.activities.remove(at: index)
        dismiss()
    }
}

struct EditActivityView_Previews: PreviewProvider {
    static var previews: some View {
        EditActivityView(habits: Activities(), activity: Activity(name: "Test1", description: "Description of Test 1"))
    }
}
