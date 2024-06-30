import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage: String?
    @State private var showAlert = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var isCreatingUser = false
    @State private var navigateToProfile = false
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack {
                    // LOGO IMAGE
                    Image("logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 120)
                        .padding(.vertical, 32)
                    
                    // FORM FIELDS
                    VStack(spacing: 24) {
                        InputView(text: $email,
                                  title: "Email Address",
                                  placeholder: "name@example.com")
                        .textInputAutocapitalization(.none)
                        
                        InputView(text: $fullname,
                                  title: "Fullname",
                                  placeholder: "Enter your name")
                        
                        InputView(text: $password,
                                  title: "Password",
                                  placeholder: "Enter your password",
                                  isSecureField: true)
                        
                        ZStack(alignment: .trailing) {
                            InputView(text: $confirmPassword,
                                      title: "Confirm Password",
                                      placeholder: "Confirm Password",
                                      isSecureField: true)
                            
                            if !password.isEmpty && !confirmPassword.isEmpty {
                                if password == confirmPassword {
                                    Image(systemName: "checkmark.circle.fill")
                                        .imageScale(.large)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(.systemGreen))
                                } else {
                                    Image(systemName: "xmark.circle.fill")
                                        .imageScale(.large)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(.systemRed))
                                }
                            }
                        }
                        
                        
                        
                        // SIGN UP BUTTON
                        Button {
                            Task {
                                do {
                                    try await createUser()
                                    navigateToProfile = true
                
                                    
                                } catch {
                                    errorMessage = error.localizedDescription
                                    showAlert = true
                                }
                            }
                        } label: {
                            HStack {
                                Text("SIGN UP")
                                    .fontWeight(.semibold)
                                Image(systemName: "arrow.right")
                            }
                            .foregroundStyle(.black)
                            .frame(width: UIScreen.main.bounds.width - 90, height: 35)
                        }
                        .background(Color.blue.opacity(0.2))
                        .disabled(!formIsValid)
                        .opacity(formIsValid ? 1.0 : 0.5)
                        .onChange(of: navigateToProfile) { newValue in
                            if newValue {
                                NavigationLink(destination: ProfileView(), isActive: $navigateToProfile) {
                                    EmptyView()
                                }
                            }
                            
                        }
                        .cornerRadius(10)
                        .padding(.top, 24)
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Sign Up Failed"), message: Text(errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
                        }
                        
                        
                        Button {
                            dismiss()
                        } label: {
                            HStack(spacing: 10) {
                                Text("Already have an account?")
                                Text("Sign in")
                                    .fontWeight(.bold)
                            }
                            .font(.system(size: 14))
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.6))
                    .padding(.horizontal, 10)
                }
            }
        }
    }
    
    private func createUser() async throws {
        isCreatingUser = true
        defer { isCreatingUser = false }
        
        try await viewModel.createUser(withEmail: email,
                                       password: password,
                                       fullname: fullname)
    }
}

extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullname.isEmpty
    }
}

extension Color {
    static let customBlue = Color(hex: "#92BCEA")
    static let customYellowGrey = Color(hex: "#C8C4AC")
    static let customLightGrey = Color(hex: "#D3D3D3")
    static let customLightYellow = Color(hex: "#FEDC56")
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xff0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00ff00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000ff) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .environmentObject(AuthViewModel()) // Add the environment object here
    }
}
