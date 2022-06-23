//
//  Activities.swift
//  Habits
//
//  Created by Thomas Schatton on 02.05.22.
//

import Foundation

class Activities: ObservableObject {
    private let savedItems = "activities"
    
    @Published var activities: Array<Activity> = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: savedItems)
            }
        }
    }
    
    init() {
        if let savedActivities = UserDefaults.standard.data(forKey: savedItems) {
            if let decodedItems = try? JSONDecoder().decode(Array<Activity>.self, from: savedActivities) {
                activities = decodedItems
                return
            }
        }
        
        activities = []
    }
    
    
    // pi chart calculations
    
    func calculatePiChart() -> [PiChartData] {
        var data = [PiChartData]()
        
        let completions = activities.map { $0.completions }
        let sortedCompletions = completions.sorted { $0 > $1 }
    
        var totalCompletions = 0
        for completion in sortedCompletions {
            totalCompletions += completion
        }
        
        let degreesPerCompletion = 360.0 / Double(totalCompletions)
        var lastEndingAngle = 0.0
        var currentCount = 1
        
        for completion in sortedCompletions {
            let currentStartAngle = lastEndingAngle
            let currentEndAngle = degreesPerCompletion * Double(completion) + lastEndingAngle
            let hue = 0.2 * Double(currentCount)
            
            let piSection = PiChartData(startAngle: .degrees(currentStartAngle), endAngle: .degrees(currentEndAngle), hue: hue)
            data.append(piSection)
            
            currentCount += 1
            lastEndingAngle = currentEndAngle
        }
        
        for dataset in data {
            dataset.printPiChartData()
        }
        
        return data
    }
}
