//
//  HitTesting.swift
//  Flashzilla
//
//  Created by Marcus Benoit on 13.08.24.
//

import SwiftUI

struct HitTesting: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped!")
                }
                            
            Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
                .contentShape(.rect)
                .onTapGesture {
                    print("Circle tapped!")
                }
            // if this is set to false, all touches will be ignored and the one behind it will be tapped
                //.allowsHitTesting(false)
        }
        
        Spacer().frame(height: 25)
        
        VStack {
            Text("Hello,")
            // Spacer will be ignored when tapped, except .contentShape(.rect) is active
            Spacer().frame(height: 100)
            Text("World!")
        }
        //.contentShape(.rect)
        .onTapGesture {
            print("VStack tapped!")
        }
    }
}

#Preview {
    HitTesting()
}
