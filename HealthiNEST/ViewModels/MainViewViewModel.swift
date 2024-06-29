

import FirebaseAuth
import Foundation

class LoginViewViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?

    init() {

    }

    public var isSignedIn: Bool {

    }
}