//
//  Assignment4App.swift
//  Assignment4
//
//  Created by Peyton Scott on 4/2/23.
//

import SwiftUI
import Firebase

@main
struct Assignment4App: App {
    
    // Initialize Firebase
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
