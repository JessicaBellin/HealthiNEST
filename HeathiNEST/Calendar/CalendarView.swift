import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var viewModel: CalendarViewModel
    @State private var newActivityTitle = ""
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Select Date", selection: $viewModel.selectedDate, displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                List {
                    ForEach(viewModel.activities[viewModel.selectedDate] ?? []) { activity in
                        Text(activity.title)
                            .onTapGesture {
                                viewModel.removeActivity(activity, from: viewModel.selectedDate)
                            }
                    }
                }
                
                HStack {
                    TextField("New Activity", text: $newActivityTitle)
                    Button("Add") {
                        viewModel.addActivity(title: newActivityTitle, for: viewModel.selectedDate)
                        newActivityTitle = ""
                    }
                }
                .padding()
                
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 20)
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: CGFloat(viewModel.completionPercentage() * UIScreen.main.bounds.width), height: 20)
                }
                .padding()
                
                Button("Check Day Completion") {
                    if viewModel.isDayCompleted() {
                        print("Day Completed! Points: \(viewModel.points)")
                    } else {
                        print("Day not completed.")
                    }
                }
            }
            .navigationTitle("Calendar")
            .padding(20)
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView().environmentObject(CalendarViewModel())
    }
}
