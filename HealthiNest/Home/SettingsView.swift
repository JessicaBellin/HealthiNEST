//
//  SettingsView.swift
//  HealthiNest
//
//  Created by Jessica Bellin on 30/06/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: CalendarViewModel
    @State private var newTaskTitle = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                List {
                    ForEach(viewModel.tasks) { task in
                        HStack {
                            Text(task.title)
                            Spacer()
                            Button(action: {
                                viewModel.removeTask(task)
                            }) {
                                Image(systemName: "trash")
                            }
                        }
                    }
                }
                HStack {
                    TextField("New Task", text: $newTaskTitle)
                    Button("Add") {
                        if !newTaskTitle.isEmpty {
                            viewModel.addTask(title: newTaskTitle)
                            newTaskTitle = ""
                        }
                    }
                }
                .padding(.horizontal)
                .padding()
            }
            .padding(.bottom, 50)
        }
        .navigationTitle("New Goals")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(CalendarViewModel())
    }
}
