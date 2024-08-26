//
//  EditCards.swift
//  Flashzilla
//
//  Created by Marcus Benoit on 21.08.24.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card", action: addCard)
                }
                
                Section("Recently added") {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].answer)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .onAppear(perform: loadData)
        }
    }
    
    func done() {
        dismiss()
    }
    
    func loadData() {
        let decoder = JSONDecoder()
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent("Cards")
        
        if let data = try? Data(contentsOf: url){
            if let decodedCards = try? decoder.decode([Card].self, from: data){
                cards = decodedCards
            }
        }
    }
    
    func saveData() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent("Cards")
        let encoder = JSONEncoder()
        do {
            let encodedCards = try encoder.encode(cards)
            try encodedCards.write(to: url,options: [.atomic,.completeFileProtection])
        } catch {
            print("Saving Error")
        }
        
        newAnswer = ""
        newPrompt = ""
    }
    
    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmpedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmpedAnswer.isEmpty == false else { return }
        
        let card = Card(id: UUID(), prompt: trimmedPrompt, answer: trimmpedAnswer)
        cards.insert(card, at: 0)
        saveData()
        
    }
    
    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
}

#Preview {
    EditCards()
}
