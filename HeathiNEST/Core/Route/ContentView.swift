import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CalendarView()
                .tabItem {
                    Label ("Calendar", systemImage: "calendar")
                }
            HomeView()
                .tabItem {
                    Label ("Home", systemImage: "house")
                }
            ProfileView()
                .tabItem {
                    Label ("Profile", systemImage: "person.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(CalendarViewModel())
    }
}
