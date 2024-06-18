import SwiftUI

class TasksViewModel: ObservableObject {
    @Published var tasksToDo: [String] = []
}
