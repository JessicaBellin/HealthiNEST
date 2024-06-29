import Foundation

struct Activity: Identifiable {
    let id = UUID()
    var title: String
}

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
}
