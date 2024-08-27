//
//  Extensions.swift
//  Flashzilla
//
//  Created by Marcus Benoit on 26.08.24.
//

import Foundation
import SwiftUI

extension View {
    func stacked(at position: Card, in total: [Card]) -> some View {
        let totalIndex = total.count
        if let positionIndex = try? total.firstIndex(of: position){
            let offset = Double(totalIndex - positionIndex)
            return self.offset(x: 0, y: offset * 5)
        }
        return self.offset(x: 0,y: 0)
    }
}
