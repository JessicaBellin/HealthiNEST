import SwiftUI

enum Activity: String, CaseIterable, Identifiable {
    case exercise = "Exercise"
    case meditate = "Meditate"
    
    var id: String { self.rawValue }
}

struct ActivityView: View {
    @EnvironmentObject var viewModel: CalendarViewModel
    @State var viewToggle: Bool = false
    let customBlue = Color(hex: 0x7BD1DC)
    var body: some View {
        NavigationView {
            ZStack {
                TabView{
                    if !viewToggle {
                        BreathingView()
                    } else {
                        ExerciseView()
                    }
                }.tabViewStyle(DefaultTabViewStyle())
                
                
                Button (action: {viewToggle = true}) {
                Text("Exercise")
                }
                .font(.system(size: 16))
                .frame(width: 160, height: 28)
                .background(Color(customBlue))
                .foregroundColor(.white)
                .cornerRadius(10)
                .offset(x: -90, y: 320)
                Button (action: {viewToggle = false}) {
                Text("Meditate")
                }
                .font(.system(size: 16))
                .frame(width: 160, height: 28)
                .background(Color(customBlue))
                .foregroundColor(.white)
                .cornerRadius(10)
                .offset(x: 90, y: 320)
            }
            
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView().environmentObject(CalendarViewModel())
    }
}
