//
//  GestureSequence.swift
//  Flashzilla
//
//  Created by Marcus Benoit on 12.08.24.
//

import SwiftUI

struct GestureSequence: View {
    // how far the circle has been dragged
    @State private var offset = CGSize.zero
    
    // whether it is currently being dragged or not
    @State private var isDragging = false
    
    var body: some View {
        // a drag gesture that updates offset and isDragging as it moves around
        let dragGesture = DragGesture()
                   .onChanged { value in offset = value.translation }
                   .onEnded { _ in
                       withAnimation {
                           offset = .zero
                               isDragging = false
                       }
                   }
        
        // a long press gesture that enables isDragging
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }
        
        // a combined gesture that forces the user to long press then drag
        let combined = pressGesture.sequenced(before: dragGesture)
        
        // a 64 x 64 circle that scales up when it's dragged, sets its offet to whatever we had back from the drag gesture, and uses our combined gesture
        Circle()
            .fill(.yellow)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
    }
}

#Preview {
    GestureSequence()
}
