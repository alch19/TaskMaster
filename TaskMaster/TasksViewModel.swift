import SwiftUI
import SwiftData

class TasksViewModel: ObservableObject {
    @Published var tasksToDo: [String] {
        didSet { //is called right after value changes
            saveTasks()
        }
    }
    
    init() {
        self.tasksToDo = UserDefaults.standard.stringArray(forKey: "tasksToDo") ?? []
    }
    
    private func saveTasks() {
        UserDefaults.standard.set(tasksToDo, forKey: "tasksToDo")
    }
}

