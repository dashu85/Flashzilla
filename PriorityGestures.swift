//
//  PriorityGestures.swift
//  Flashzilla
//
//  Created by Marcus Benoit on 12.08.24.
//

import SwiftUI

struct PriorityGestures: View {
    var body: some View {
        // if two gestures clash - child view will have priority!!
        
        // however, you can prioritize gestures like this:
        
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .onTapGesture {
                    print("Text tapped")
                }
                
        }
        .highPriorityGesture(
            TapGesture()
                .onEnded {
                    print("VStack tapped")
                }
        )
        .padding()
        
        // You can even have simultaneous Gestures like this
        
        VStack {
            Text("Simultaneous Gesture")
                .onTapGesture {
                    print("Text tapped")
                }
                .padding()
        }
        .simultaneousGesture(
            TapGesture()
                .onEnded {
                    print("VStack tapped")
                }
        )
    }
}

#Preview {
    PriorityGestures()
}
