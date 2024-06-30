import Foundation
//
//struct Activity: Identifiable {
//    let id = UUID()
//    var title: String
//}

struct ToDo: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
}
