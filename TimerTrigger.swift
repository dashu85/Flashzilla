//
//  TimerTrigger.swift
//  Flashzilla
//
//  Created by Marcus Benoit on 13.08.24.
//

import Foundation
import SwiftUI

struct TimerTrigger: View {
    // tolerance is for battery savings
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    var body: some View {
        Text("Hello, World!")
            .onReceive(timer) { time in
                if counter == 5 {
                    // stops the timer from executing
                    timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }
                
                counter += 1
            }
    }
}

#Preview {
    TimerTrigger()
}
