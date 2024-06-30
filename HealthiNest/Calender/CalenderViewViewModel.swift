import Foundation
import Combine

class CalendarViewModel: ObservableObject {
    @Published var selectedDate: Date = Date()
    @Published var tasks: [ToDo] = []
    @Published var hoursOfSleep: Double = 7
    @Published var foodHealthiness: Double = 3
    @Published var healthTarget: Double = 100 // Default to 100%
    @Published var points: Int = 0
    @Published var selectedActivity: Activity = .exercise
    
    func addTask(title: String) {
        let task = ToDo(title: title, isCompleted: false)
        tasks.append(task)
    }
    
    func removeTask(_ task: ToDo) {
        if let index = tasks.firstIndex(where: { $0.id == task.id}) {
            tasks.remove(at: Int(index))
        }
    }
    
    func toggleTaskCompletion(_ task: ToDo) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            if tasks[index].isCompleted {
                points += 20
            } else {
                points -= 20
            }
        }
    }
    
    func completionPercentage() -> Double {
        let requiredCompletion: Double
        if healthTarget == 100 {
            requiredCompletion = 0.3
        } else if healthTarget == 90 {
            requiredCompletion = 0.4
        } else if healthTarget == 80 {
            requiredCompletion = 0.5
        } else if healthTarget == 70 {
            requiredCompletion = 0.6
        } else if healthTarget == 60 {
            requiredCompletion = 0.7
        } else if healthTarget == 50 {
            requiredCompletion = 0.8
        } else if healthTarget == 40 {
            requiredCompletion = 0.9
        } else if healthTarget == 30 {
            requiredCompletion = 1
        } else {
            requiredCompletion = 1.1
        }
        let completedTasks = tasks.filter { $0.isCompleted }.count
        let taskCompletion = tasks.isEmpty ? 0.0 : Double(completedTasks) / Double(tasks.count)
        let sleepCompletion: Double
        if hoursOfSleep == 7 || hoursOfSleep == 8 {
            sleepCompletion = 1.0
        } else {
            sleepCompletion = max(0.0, 1.0 - (hoursOfSleep - 8) * 0.1)
        }
        let foodCompletion = foodHealthiness / 5.0
        return (taskCompletion + sleepCompletion + foodCompletion)  / (3.0 - requiredCompletion)
    }
    
    func isDayCompleted() -> Bool {
        let completionPercentage = completionPercentage()
        if completionPercentage > 1 {
            let bonusMultiplier = healthTarget == 100 ? 1.5 : healthTarget == 70 ? 1.0 : 0.5
                        points += Int(100 * bonusMultiplier)
            return true
        }
        return false
    }
}
