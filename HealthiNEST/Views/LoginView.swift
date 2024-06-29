

import SwiftUI

struct LoginView: View {
    @StateObject: var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HeaderView  (title: "",
                             subtitles: "",
                             background: .red)
                // Login Form (email, password, button())

                // Create Account

            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}