//
//  ContentView.swift
//  Flashzilla
//
//  Created by Marcus Benoit on 12.08.24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    
    @State private var cards = [Card]()
    
    // timer properties
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // check if app is in background properties
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true

    @State private var score = 0
    
    @State private var showingEditingScreen = false
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
                    VStack {
                        Spacer()
                        
                        HStack {
                            Button {
                                withAnimation {
                                    // TODO: remove card
                                }
                            } label: {
                                Image(systemName: "xmark.circle")
                                    .padding()
                                    .background(.black.opacity(0.7))
                                    .font(.largeTitle)
                                    .clipShape(.circle)
                            }
                            .accessibilityLabel("Wrong")
                            .accessibilityHint("Mark your answer as being incorrect")
                            
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    // TODO: remove card
                                }
                            } label: {
                                Image(systemName: "checkmark.circle")
                                    .padding()
                                    .background(.black.opacity(0.7))
                                    .font(.largeTitle)
                                    .clipShape(.circle)
                            }
                            .accessibilityLabel("Correct")
                            .accessibilityHint("Mark your answer as being correct")
                        }
                    }
                }
                
                if !accessibilityDifferentiateWithoutColor && !accessibilityVoiceOverEnabled{
                    HStack {
                        Text("Time: \(timeRemaining)")
                            .padding()
                            .font(.largeTitle)
                            .background(.black.opacity(0.7))
                            .clipShape(.capsule)
                    }
                }
                
                ZStack {
                    ForEach(cards) { card in
                        CardView(card: card) { isCorrect in
                            if !isCorrect {
                                withAnimation {
                                    let newCard = Card(id: UUID(), prompt: card.prompt, answer: card.answer)
                                    cards.remove(at: getIndex(of: card))
                                    cards.insert(newCard, at: 0)
                                    score -= 1
                                }
                            } else {
                                withAnimation {
                                    removeCard(at: getIndex(of: card))
                                    score += 1
                                }
                            }
                        }
                        .stacked(at: card, in: cards)
                        .allowsHitTesting(getIndex(of: card) == cards.count - 1)
                        .accessibilityHidden(getIndex(of: card) < cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start again!", action: resetCards)
                        .padding()
                        .font(.largeTitle)
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                }
            }
            
            VStack {
                HStack {
                    Button {
                        showingEditingScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                    
                    Spacer()
                    
                    Text("Score: \(score)")
                        .padding()
                        .font(.largeTitle)
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                }
                
                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditingScreen, onDismiss: resetCards, content: EditCards.init)
        .onAppear(perform: resetCards)
    }
    
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        cards.remove(at: index)
        
        if cards.isEmpty {
            isActive = false
        }
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
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        score = 0
        loadData()
    }
    
    func getIndex(of card: Card) -> Int {
        for i in 0...cards.count {
            if cards[i].id == card.id {
                return i
            }
        }
        return -1
    }
}

#Preview {
    ContentView()
}
