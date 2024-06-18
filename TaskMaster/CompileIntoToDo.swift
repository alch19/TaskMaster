import SwiftUI

struct CompileIntoToDo: View {
    @EnvironmentObject var tasksViewModel: TasksViewModel
    @State private var userInput=""
    @FocusState private var isFocused: Bool
    @State private var tasksToDo: [String] = []
    @State private var showMenuPage=false
    @State private var showAlert=false
    @State private var navigateToToDoListMaker=false
    
    var body: some View {
        VStack {
            Text("Compile Into Magic")
                .font(.largeTitle)
                .padding()
                .bold()
            
            TextField("Enter Your Tasks. Seperate them with commas", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .focused($isFocused)
            
            Button(action: {
                compileTasks()
                showAlert=true
            }) {
                Text("Turn This Into A List")
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.accentColor)
                    .cornerRadius(20)
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .onTapGesture {
            isFocused = false
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("List Created!"),
                message: Text("Your list is now in the Magic List"),
                dismissButton: .default(Text("OK"), action: {
                    navigateToToDoListMaker=true
                })
            )
        }
        
        .navigationDestination(isPresented: $navigateToToDoListMaker) {
            ToDoListMaker(tasks: tasksViewModel.tasksToDo)
        }
        
        .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action: {
                    showMenuPage=true
                }) {
                    HStack {
                        Image(systemName: "line.horizontal.3.circle")
                    }
                })
                .fullScreenCover(isPresented: $showMenuPage) {
                    MenuPage()
                }
    }
    private func compileTasks() {
        tasksViewModel.tasksToDo = userInput.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
           isFocused = false
       }
    
}

#Preview {
    NavigationStack {
        CompileIntoToDo()
            .environmentObject(TasksViewModel())
    }
}
