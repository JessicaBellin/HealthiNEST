//
//  CalenderViewViewModel.swift
//  HealthiNest
//
//  Created by Jessica Bellin on 30/06/24.
//

import Foundation
import Combine

class CalendarViewModel: ObservableObject {
    @Published var selectedDate = Date()
    @Published var activities: [Date: [Activity]] = [:]
    @Published var tasks: [ToDo] = []
    @Published var hoursOfSleep: Double = 7
    @Published var foodHealthiness: Double = 3
    @Published var healthTarget: Double = 100 // Default to 100%
    @Published var points: Int = 0
    
    func addActivity(title: String, for date: Date) {
        let activity = Activity(title: title)
        if activities[date] != nil {
            activities[date]?.append(activity)
        } else {
            activities[date] = [activity]
        }
    }
    
    func removeActivity(_ activity: Activity, from date: Date) {
        activities[date]?.removeAll { $0.id == activity.id }
    }
    
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
            let completedTasks = tasks.filter { $0.isCompleted }.count
            let taskCompletion = tasks.isEmpty ? 0.0 : Double(completedTasks) / Double(tasks.count)
            let sleepCompletion: Double
            if hoursOfSleep == 7 || hoursOfSleep == 8 {
                sleepCompletion = 1.0
            } else if hoursOfSleep < 7 {
                sleepCompletion = hoursOfSleep / 7.0
            } else {
                sleepCompletion = max(0.0, 1.0 - (hoursOfSleep - 8) * 0.05)
            }
            let foodCompletion = foodHealthiness / 5.0
            return (taskCompletion + sleepCompletion + foodCompletion) / 3.0
        }
        
        func isDayCompleted() -> Bool {
            let completionPercentage = completionPercentage()
            let requiredCompletion = healthTarget == 100 ? 0.9 : healthTarget == 70 ? 0.7 : 0.4
            if completionPercentage >= requiredCompletion {
                let bonusMultiplier = healthTarget == 100 ? 1.5 : healthTarget == 70 ? 1.0 : 0.5
                points += Int(100 * bonusMultiplier)
                return true
            }
            return false
        }
    }
