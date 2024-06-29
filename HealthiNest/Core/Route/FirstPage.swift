//
//  FirstPage.swift
//  HealthiNest
//
//  Created by Jessica Bellin on 30/06/24.
//

import SwiftUI

struct FirstView: View {
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

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView().environmentObject(CalendarViewModel())
    }
}
