//
//  ContentView.swift
//  FlashcardLab
//
//  Created by Bender on 3/16/24.
//
// Import the SwiftUI framework in any file you want to use SwiftUI
import SwiftUI
// Define the ContentView structure, which conforms to the View protocol
struct ContentView: View {
    @State private var cards: [Card] = Card.mockedCards
    @State private var cardsToPractice: [Card] = [] // <-- Store cards removed from cards array
    @State private var cardsMemorized: [Card] = [] // <--
    @State private var deckId: Int = 0
    //Modal to add new flashcard by user
    @State private var createCardViewPresented = false
    var body: some View {
        
        // Card deck
        //Loop to iterate through card deck in cardView
            ZStack {
                
                // Reset buttons
                  VStack { // <-- VStack to show buttons arranged vertically behind the cards
                     Button("Reset") { // <-- Reset button with title and action
                         cards = cardsToPractice + cardsMemorized // <-- Reset the cards array with cardsToPractice and cardsMemorized
                         cardsToPractice = [] // <-- set both cardsToPractice and cardsMemorized to empty after reset
                         cardsMemorized = [] // <--
                         deckId += 1
                     }
                     .disabled(cardsToPractice.isEmpty && cardsMemorized.isEmpty)

                     Button("More Practice") { // <-- More Practice button with title and action
                         cards = cardsToPractice // <-- Reset the cards array with cardsToPractice
                         cardsToPractice = [] // <-- Set cardsToPractice to empty after reset
                         deckId += 1 
                     }
                     .disabled(cardsToPractice.isEmpty)
                 }
                
                ForEach(0..<cards.count, id: \.self) { index in
                    CardView(card: cards[index], onSwipedLeft: {
                        let removedCard = cards.remove(at: index) // <-- Get the removed card
                        cardsToPractice.append(removedCard) // <-- Add removed card to cards to practice array
                    }, onSwipedRight: {
                        let removedCard = cards.remove(at: index) // <-- Get the removed card
                        cardsMemorized.append(removedCard) // <-- Add removed card to memorized cards array
                    })
                    CardView(card: cards[index]).rotationEffect(.degrees(Double(cards.count - 1 - index) * -5))
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity).overlay(alignment: .topTrailing) { // <-- Add an overlay modifier with top trailing alignment for its contents
                Button("Add Flashcard", systemImage: "plus") {  // <-- Add a button to add a flashcard
                    createCardViewPresented.toggle() // <-- Toggle the createCardViewPresented value to trigger the sheet to show
                }
            }.animation(.bouncy, value: cards).id(deckId).sheet(isPresented: $createCardViewPresented, content: {
                CreateFlashcardView { card in
                    cards.append(card)
                }
            })

       
        
        
    }
}
// Preview the ContentView in the canvas
#Preview {
    ContentView()
}

//Starter Code for reference on how SwiftUI works
// Vertical stack (VStack) to arrange views vertically
//        VStack {
//            // Image view with the system's globe icon
//            Image(systemName: "dog")
//                .imageScale(.large)// Set the image scale to large
//                .foregroundStyle(.pink)// Set the image color to the tint color
//            // Text view displaying the "Hello, world!" string
//            Text("Hello, world! \nIt is very exciting to learn SwiftUI!")
//        }
//        .padding() // Apply padding to the entire VStack
