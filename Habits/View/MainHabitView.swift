//
//  ContentView.swift
//  Habits
//
//  Created by Thomas Schatton on 02.05.22.
//

import SwiftUI

struct MainHabitView: View {
    @StateObject private var habits = Activities()
    
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationView {
            VStack {
                PiChartView(habits: habits)
                    .frame(width: 150, height: 150, alignment: .center)

                ScrollView {
                    Section {
                        ForEach(habits.activities) { item in
                            NavigationLink {
                                EditActivityView(habits: habits, activity: item)
                            } label: {
                                ListDetailView(habits: habits, activity: item)
                            }
                        }
                        .onDelete(perform: removeItems)
                    }
                    .padding()
                }
            }
            .navigationTitle("My Habits")
            .toolbar {
                Button {
                    showingAddActivity = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddActivityView(habits: habits)
            }
        }
    }
    
    func removeItems(at offset: IndexSet) {
        habits.activities.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainHabitView()
    }
}
