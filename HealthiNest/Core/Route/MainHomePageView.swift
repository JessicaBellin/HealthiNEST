import SwiftUI

struct MainHomePageView: View {

    var body: some View {
        TabView {
            ActivityView()
                .tabItem {
                    Label ("Activity", systemImage: "dumbbell")
                }
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

struct MainHomePageView_Previews: PreviewProvider {
    static var previews: some View {
        MainHomePageView()
            .environmentObject(AuthViewModel())
            .environmentObject(CalendarViewModel()) // Add the environment object here
    }
}
