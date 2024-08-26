//
//  AccessibilitySupport.swift
//  Flashzilla
//
//  Created by Marcus Benoit on 14.08.24.
//

import SwiftUI

struct AccessibilitySupport: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale = 1.0
    
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    var body: some View {
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }
            
            Text("Success")
        }
        .padding()
        .background(differentiateWithoutColor ? .black : .green)
        .foregroundColor(.white)
        .clipShape(.capsule)
        
        Spacer().frame(height: 50)
        
        Button("Hello World") {
            if reduceMotion {
                scale *= 1.5
            } else {
                withAnimation {
                    scale *= 1.5
                }
            }
        }
        .scaleEffect(scale)
        
        Spacer().frame(height: 50)
        
        Button("Reduce Animatino") {
            withOptionalAnimation {
                scale *= 1.5
            }
        }
        .scaleEffect(scale)
        
        Spacer().frame(height: 50)
        
        Text("Reduce Transparency")
            .padding()
            .background(reduceTransparency ? .gray : .gray.opacity(0.5))
            .foregroundStyle(.white)
            .clipShape(.capsule)
    }
    
    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
}

#Preview {
    AccessibilitySupport()
}
