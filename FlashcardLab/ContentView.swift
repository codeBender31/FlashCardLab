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
    var body: some View {
        
        // Card deck
        //Loop to iterate through card deck in cardView
            ZStack {
                ForEach(0..<cards.count, id: \.self) { index in
                    CardView(card: cards[index], onSwipedLeft: { // <-- Add swiped left property
                        cards.remove(at: index) // <-- Remove the card from the cards array
                    }, onSwipedRight: { // <-- Add swiped right property
                        cards.remove(at: index) // <-- Remove the card from the cards array
                    })
                    CardView(card: cards[index]).rotationEffect(.degrees(Double(cards.count - 1 - index) * -5))
                }
            }
       
        
        
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
