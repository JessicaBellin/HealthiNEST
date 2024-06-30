import SwiftUI

struct HealthTargetView: View {
    @EnvironmentObject var viewModel: CalendarViewModel
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Set Health Target")
                Slider(value: $viewModel.healthTarget, in: 20...100, step: 10)
                Text("Health Target: \(Int(viewModel.healthTarget))%")
                    .padding()
                Text("Bonus points: \(Int(viewModel.healthTarget * 1.5))%")
            }
            .padding()
            .padding()
            .padding()
            .navigationTitle("Health Target")
        }
    }
}

struct HealthTargetView_Previews: PreviewProvider {
    static var previews: some View {
        HealthTargetView().environmentObject(CalendarViewModel())
    }
}
