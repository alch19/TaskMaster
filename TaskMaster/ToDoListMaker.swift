import SwiftUI
import SwiftData

struct ToDoListMaker: View {
    var tasks: [String]
    @EnvironmentObject var tasksViewModel: TasksViewModel
    @State private var showMenuPage=false
    
    var body: some View {
        VStack {
            Divider()
            Text("To-Do List")
                .font(.largeTitle)
                .bold()
            Divider()
                .padding(.bottom, 100)
            Spacer()
            if tasksViewModel.tasksToDo.isEmpty {
                
                Text("You're out of tasks!")
                    .font(.largeTitle)
                    .foregroundColor(.accentColor)
                    .padding()
                    .bold()
                Spacer()
                Spacer()
            }
            else {
                List {
                    ForEach(tasksViewModel.tasksToDo, id: \.self) { task in
                        Text(task)
                    }
                    .onDelete(perform: deleteTask)
                }
                .listStyle(PlainListStyle())
                .background(.clear)
            }
        }
        
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            showMenuPage=true
        }) {
            HStack {
                Image(systemName: "line.horizontal.3.circle")
            }
            .font(.largeTitle)
            
        })
        .fullScreenCover(isPresented: $showMenuPage) {
            MenuPage()
        }
    }
    private func deleteTask(at offsets: IndexSet) {
            tasksViewModel.tasksToDo.remove(atOffsets: offsets)
    }
}

struct ToDoListMaker_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListMaker(tasks: ["Task 1", "Task 2"])
            .environmentObject(TasksViewModel())
    }
}
