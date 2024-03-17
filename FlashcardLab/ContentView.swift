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
    var body: some View {
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
        

//Wrap in a Z stack to display card body
    ZStack{
        //Specify card body
        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).fill(Color.blue.gradient)
        //Wrap current card Text in a VStack and add another Text above
        VStack(spacing: 20){
            //Add another text
            Text("Question").bold()
        //Separator
            Rectangle().frame(height: 1)
        
            //Card Text
        Text("Located at the southern end of the Puget Sound, what is the capitol of Washington?")
            
        }.font(.title).foregroundStyle(.white).padding().shadow(color: .black, radius: 4, x: -2, y: 2)
    }.frame(width: 300, height: 500)
    }
}
// Preview the ContentView in the canvas
#Preview {
    ContentView()
}
