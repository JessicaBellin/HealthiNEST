import SwiftUI

@main
struct HeathiNESTApp: App {
    @StateObject private var calendarViewModel = CalendarViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(calendarViewModel)
            RegistrationView()
        }
    }
}
