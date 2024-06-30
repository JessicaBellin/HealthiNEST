import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: CalendarViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Text("⚡0")
                    .font(.system(size: 30))
                    .offset(x: 130, y: -337)
                VStack {
                    VStack {
                        Text("Hours of Sleep")
                        Slider(value: $viewModel.hoursOfSleep, in: 1...15, step: 1)
                        Text("\(Int(viewModel.hoursOfSleep)) hours")
                    }
                    .padding()
                    
                    VStack {
                        Text("Healthiness of Food")
                        Slider(value: $viewModel.foodHealthiness, in: 1...5, step: 1)
                        Text("\(Int(viewModel.foodHealthiness))")
                    }
                    .padding()
                    
                    List {
                        ForEach(viewModel.tasks) { task in
                            HStack {
                                Text(task.title)
                                Spacer()
                                Button(action: {
                                    viewModel.toggleTaskCompletion(task)
                                }) {
                                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                }
                                .foregroundColor(task.isCompleted ? .green : .red)
                            }
                        }
                    }
                    
                    NavigationLink("Set Your Goals", destination: SettingsView())
                        .padding(.bottom, 20)
                    
                    
                }
                .navigationTitle("Home")
                .padding()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(CalendarViewModel())
    }
}
