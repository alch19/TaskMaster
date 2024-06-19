import SwiftUI
import SwiftData

@main
struct TaskMasterApp: App {
    @StateObject private var tasksViewModel = TasksViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(tasksViewModel)
        }
    }
}

