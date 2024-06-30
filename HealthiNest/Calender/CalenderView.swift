import SwiftUI



struct CalendarView: View {
    @EnvironmentObject var viewmodel: CalendarViewModel
    @State private var newActivityTitle = ""
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Select Date", selection: $viewmodel.selectedDate, displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                Spacer()
                
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 30)
                    
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.green)
                            .frame(width: min(CGFloat(viewmodel.completionPercentage()) * geometry.size.width * 1.19, geometry.size.width), height: 30)
                    }
                }
                .frame(height: 30)
                .padding(.horizontal)
                .padding(.bottom, 40)
                
//                Button("Check Day Completion") {
//                    if viewModel.isDayCompleted() {
//                        print("Day Completed! Points: \(viewModel.points)")
//                    } else {
//                        print("Day not completed.")
//                    }
//                }
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
