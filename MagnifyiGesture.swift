//
//  MagnifyiGesture.swift
//  Flashzilla
//
//  Created by Marcus Benoit on 12.08.24.
//

import SwiftUI

struct MagnifyiGesture: View {
    @State private var currentAmount = 0.0
    @State private var finalAmount = 1.0
    
    var body: some View {
        Text("MagnifyGesture")
            .scaleEffect(finalAmount + currentAmount)
            .gesture(
                // Pinch and zoom gesture
                
                MagnifyGesture()
                    .onChanged { value in
                        currentAmount = value.magnification - 1
                    }
                    .onEnded { value in
                        finalAmount += currentAmount
                        currentAmount = 0
                    }
            )
    }
}

#Preview {
    MagnifyiGesture()
}
