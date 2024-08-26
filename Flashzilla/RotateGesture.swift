//
//  RotateGesture.swift
//  Flashzilla
//
//  Created by Marcus Benoit on 12.08.24.
//

import SwiftUI

struct RotateGesture: View {
    @State private var currentAmount = Angle.zero
    @State private var finalAmount = Angle.zero
    
    var body: some View {
        Text("RotateGesture")
            .rotationEffect(currentAmount + finalAmount)
            .gesture(
                RotationGesture()
                    .onChanged { value in
                        currentAmount = Angle(degrees: value.degrees
                        )
                    }
                    .onEnded { value in
                        finalAmount += currentAmount
                        currentAmount = .zero
                    }
            )
    }
}

#Preview {
    RotateGesture()
}
