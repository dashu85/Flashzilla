//
//  MovedToBackgroundNotification.swift
//  Flashzilla
//
//  Created by Marcus Benoit on 14.08.24.
//

import SwiftUI

struct MovedToBackgroundNotification: View {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onChange(of: scenePhase) { oldPhase, newPhase in
                if newPhase == .active {
                    print("Active")
                    // user isn't able to access able, e.g. control center, app switcher
                } else if newPhase == .inactive {
                    print("Inactive")
                    // app is in background or closed
                } else if newPhase == .background {
                    print("Background")
                }
            }
    }
}

#Preview {
    MovedToBackgroundNotification()
}
