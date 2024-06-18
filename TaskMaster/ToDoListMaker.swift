import SwiftUI

struct ToDoListMaker: View {
    var tasks: [String]

    var body: some View {
        List(tasks, id: \.self) { task in
            Text(task)
        }
        .navigationTitle("To-Do List")
    }
}

#Preview {
    ToDoListMaker(tasks: ["Task 1", "Task 2"])
}
