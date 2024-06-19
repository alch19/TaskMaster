import SwiftUI

class TasksViewModel: ObservableObject {
    @Published var tasksToDo: [String] = []
    @Published var isCompleted: [Bool] = []
}
