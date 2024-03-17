//
//  FlashcardLabApp.swift
//  FlashcardLab
//
//  Created by Bender on 3/16/24.
//

import SwiftUI
// The @main attribute indicates that FlashcardStarterApp is the entry point for the app.
@main
// The 'body' property is required for any SwiftUI App. It defines the content of the app.
struct FlashcardLabApp: App {
    // A Scene represents a single user interface within the app.
    var body: some Scene {
        // The WindowGroup represents the main window of the app.
        WindowGroup {
            ContentView()
            // ContentView is the main view or the root view of the app.
            // This is where you start defining the structure and content of your app's user interface.
        }
    }
}
