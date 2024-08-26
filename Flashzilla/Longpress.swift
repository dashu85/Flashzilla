//
//  Longpress.swift
//  Flashzilla
//
//  Created by Marcus Benoit on 12.08.24.
//

import SwiftUI

struct Longpress: View {
    var body: some View {
        Spacer()
        
        Text("Long press - 2 sec")
            .onLongPressGesture {
                print("Long pressed!")
            }
        
        Spacer()
        
        Text("Long press - in progress")
            .onLongPressGesture(minimumDuration: 3) {
                print("really long pressed")
            } onPressingChanged: { inProgress in
                print("In progress: \(inProgress)")
            }
        
        Spacer()
    }
}

#Preview {
    Longpress()
}
