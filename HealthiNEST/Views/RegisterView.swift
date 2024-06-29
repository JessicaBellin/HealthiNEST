

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HeaderView  (title: "",
                             subtitles: "",
                             background: .orange)
                // Register Form (Fullname, email, password)

                // Login
                
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}