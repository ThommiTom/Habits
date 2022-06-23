//
//  PiChartData.swift
//  Habits
//
//  Created by Thomas Schatton on 03.05.22.
//

import Foundation
import SwiftUI

struct PiChartData: Identifiable, Equatable {
    var id = UUID()
    var startAngle: Angle
    var endAngle: Angle
    var hue: Double
    
    func printPiChartData() {
        print("id: \(id)")
        print("Angles: \(startAngle) - \(endAngle)")
        print("Color: \(hue)")
    }
}
