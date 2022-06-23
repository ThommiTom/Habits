//
//  Arc.swift
//  Habits
//
//  Created by Thomas Schatton on 03.05.22.
//

import SwiftUI

struct ArcShape: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = true
    var insetAmount = 0.0
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(startAngle.degrees, endAngle.degrees) }
        set {
            startAngle = Angle.degrees(newValue.first)
            endAngle = Angle.degrees(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = rect.width / 2
        
        var path = Path()
        
        path.move(to: center)
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: radius, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        path.addLine(to: center)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct Arc: View {
    @State private var startAngle: Angle = .degrees(0)
    @State private var endAngle: Angle = .degrees(0)
    @State private var hue: Double
    
    init(start: Angle, end: Angle, hue: Double) {
        _startAngle = State(initialValue: start)
        _endAngle = State(initialValue: end)
        _hue = State(initialValue: hue)
    }
    
    var body: some View {
        VStack {
            ArcShape(startAngle: startAngle, endAngle: endAngle)
                .fill(Color(hue: hue, saturation: 0.7, brightness: 0.7))
            
//
            
        }
    }
}

struct Arc_Previews: PreviewProvider {
    static var previews: some View {
        Arc(start: .degrees(0), end: .degrees(0), hue: 1)
    }
}
