//
//  PiChartView.swift
//  Habits
//
//  Created by Thomas Schatton on 03.05.22.
//

import SwiftUI

struct PiChartView: View {
    @ObservedObject private var habits: Activities
    
    init(habits: Activities) {
        self.habits = habits
    }
    
    var body: some View {
        ZStack {
            ForEach(habits.calculatePiChart(), id: \.id) { section in
                Arc(start: section.startAngle, end: section.endAngle, hue: section.hue)
            }
        }
    }
}

struct PiChartView_Previews: PreviewProvider {
    static var previews: some View {
        PiChartView(habits: Activities())
    }
}
