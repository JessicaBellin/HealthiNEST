import SwiftUI
import Firebase

@main
struct HealthiNestApp: App {
    @StateObject var viewModel = AuthViewModel() // environment object, GETS INITIALIZED ONCE
    @StateObject private var viewmodel = CalendarViewModel()
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(viewmodel)
        }
    }
}
