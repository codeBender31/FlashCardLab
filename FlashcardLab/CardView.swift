//
//  CardView.swift
//  FlashcardLab
//
//  Created by Bender on 3/16/24.
//

import Foundation
import SwiftUI

//Template for each card
struct CardView: View {
    let card: Card
    var onSwipedLeft: (() -> Void)? // <-- Add closures to be called when user swipes left or right
      var onSwipedRight: (() -> Void)? // <--
    @State private var isShowingQuestion = true
    @State private var offset: CGSize = .zero // <-- A state property to store the offset
    private let swipeThreshold: CGFloat = 200 // <--- Define a swipeThreshold constant top level
    
    var body: some View {
            ZStack {
                             //Back-most card background
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(offset.width < 0 ? Color.red : Color.green) // <-- Set fill based on offset (swipe left vs right)
                // Front-most card background (i.e. original background)
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(isShowingQuestion ? Color.blue.gradient: Color.indigo.gradient)
                    .shadow(color: .black, radius: 4, x: -2, y: 2)
                    .opacity(CGFloat(1 - abs(offset.width) / swipeThreshold))
                  
                //Wrap current card Text in a VStack and add another Text above
                VStack(spacing: 20) {
                    // Add another text
                    Text(isShowingQuestion ? "Question" : "Answer").bold()
                    // Separator
                    Rectangle().frame(height: 1)
                    // Card Text
                    Text(isShowingQuestion ? card.question : card.answer)
                }
                .font(.title)
                .foregroundStyle(.white)
                .padding()
                .shadow(color: .black, radius: 4, x: -2, y: 2)
            }
            .frame(width: 300, height: 500)
            .onTapGesture {
                isShowingQuestion.toggle()
            }.opacity(Double(3 - abs(offset.width) / swipeThreshold * 3)).rotationEffect(.degrees(offset.width / 20.0))
            .offset(CGSize(width: offset.width, height: 0))
            .gesture(DragGesture().onChanged { gesture in // <-- onChanged called for every gesture value change, like when the drag translation changes
                    let translation = gesture.translation // <-- Get the current translation value of the gesture. (CGSize with width and height)
                    print(translation) // <-- Print the translation value
                    offset = translation // <-- update the state offset property as the gesture translation changes
                }.onEnded { gesture in  // <-- onEnded called when gesture ends
                    
                    if gesture.translation.width > swipeThreshold { // <-- Compare the gesture ended translation value to the swipeThreshold
                        print("👉 Swiped right")
                        onSwipedRight?() // <-- Call swiped right closure

                    } else if gesture.translation.width < -swipeThreshold {
                        print("👈 Swiped left")
                        onSwipedLeft?() // <-- Call swiped left closure

                    } else {
                        print("🚫 Swipe canceled")
                        withAnimation(.bouncy) { // <-- Make updates to state managed property with animation
                            offset = .zero//move back to original position
                            isShowingQuestion = true // Reset isShowingQuestion here
                        }
                    }
                }
            )
        }/*.animation(.bouncy, value: cards)*/
        //Background closing brace
    }//Body Closing brace
//}//struct closing brace

#Preview {
    CardView(card: Card (
           question: "Located at the southern end of Puget Sound, what is the capitol of Washington?",
           answer: "Olympia"))
}

////Create a card model
struct Card: Equatable{
    //define the fields
    let question: String
    let answer: String
    static let mockedCards = [
           Card(question: "When was the first iPhone released?", answer: "June 29, 2007"),
           Card(question: "What was the original name of the Apple Watch before its release?", answer: "iWatch"),
           Card(question: "What was the code name for the original Macintosh computer?", answer: "Macintosh 128k"),
           Card(question: "Which Apple product was introduced in 1984 and became the first commercially successful personal computer to feature a mouse and a graphical user interface?", answer: "Macintosh"),
           Card(question: "What was the first Apple product to use the Retina display?", answer: "iPhone 4")
       ]}

