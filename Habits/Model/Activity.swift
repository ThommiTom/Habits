//
//  Activity.swift
//  Habits
//
//  Created by Thomas Schatton on 02.05.22.
//

import Foundation

struct Activity: Identifiable, Codable, Equatable {
    var id = UUID()
    
    var name: String
    var description: String
    var completions = 0
    
    func printDetails() {
        print("id: \(id)")
        print("name: \(name)")
        print("descr: \(description)")
        print("completions: \(completions)")
    }
}
