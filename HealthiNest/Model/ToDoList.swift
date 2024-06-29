//
//  ToDoList.swift
//  HealthiNest
//
//  Created by Jessica Bellin on 30/06/24.
//

import Foundation

struct Activity: Identifiable {
    let id = UUID()
    var title: String
}

struct ToDo: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
}
