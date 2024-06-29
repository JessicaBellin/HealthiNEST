//
//  HeathiNESTApp.swift
//  HeathiNEST
//

import SwiftUI
import Firebase

@main
struct HeathiNESTApp: App {
    @StateObject var viewModel = AuthViewModel() // environment object, GETS INITIALIZED ONCE
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
