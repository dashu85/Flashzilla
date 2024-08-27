//
//  Card.swift
//  Flashzilla
//
//  Created by Marcus Benoit on 15.08.24.
//

import Foundation
import SwiftData

struct Card: Codable, Hashable, Identifiable {
    let id: UUID
    var prompt: String
    var answer: String
    
    static let example = Card(id: UUID(), prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
