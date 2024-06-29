import SwiftUI

extension Color {
//    static let customYellow = Color(hex: "#EFCB68")
    static let customBlue = Color(hex: "#92BCEA")
    static let customYellowGrey = Color(hex: "#C8C4AC")
    static let customLightGrey = Color(hex: "#D3D3D3")
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

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.customBlue, Color.customYellowGrey]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all) // Background gradient
            
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 25)
                    .padding(.vertical, 30)
                
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
                    
                    InputView(text: $confirmPassword,
                              title: "Confirm Password",
                              placeholder: "Confirm Password",
                              isSecureField: true)
                    
                    Button {
                        print("Sign user up..")
                    } label: {
                        HStack {
                            Text("SIGN UP")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                        }
                        .foregroundStyle(.blue)
                        .frame(width: UIScreen.main.bounds.width - 90, height: 30)
                    }
                    .background(Color(.white.opacity(0.5)))
                    .cornerRadius(10)
                    .padding(.top, 24)
                    
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 10) {
                            Text("Don't have an account?")
                            Text("Sign up")
                                .fontWeight(.bold)
                        }
                        .font(.system(size: 14))
                    }
                    
                }
                .padding()
                //.background(Color.white.opacity(0.9)) //  box background
                .background(Color.white.opacity(0.8))
                .cornerRadius(17)
                .padding(.horizontal, 15)
            }
        }
    }
}

#Preview {
    RegistrationView()
}
