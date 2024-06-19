import SwiftUI
import SwiftData

struct CompileIntoToDo: View {
    @EnvironmentObject var tasksViewModel: TasksViewModel
    @State private var userInput=""
    @State private var thingsToAdd=""
    @FocusState private var isFocused: Bool
    @State private var tasksToDo: [String] = []
    @State private var showMenuPage=false
    @State private var showAlert=false
    @State private var showAlert2=false
    @State private var navigateToToDoListMaker=false
    @State private var showLabel1=false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Divider()
                Text("Compile Into List")
                    .font(.largeTitle)
                    .padding()
                    .bold()
                Divider()
                TextField("Enter Your Tasks. Seperate them with commas", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .focused($isFocused)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("List Created!"),
                            message: Text("Your list is now in the Magic List"),
                            dismissButton: .default(Text("OK"), action: {
                                
                            })
                        )
                    }
                Button(action: {
                    compileTasks()
                    showAlert=true
                    showLabel1=true
                }) {
                    Text("Turn This Into A List")
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(20)
                        .padding(.horizontal, 8)
                }
                .buttonStyle(FilledButtonStyle2(color: .accentColor))
                .padding()
                
                Spacer()
                
                TextField("Add a single item", text: $thingsToAdd)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .focused($isFocused)
                
                Button(action: {
                    addTask()
                    showAlert2=true
                }) {
                    Text("Submit")
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(20)
                        .padding(.horizontal, 60)
                }
                .buttonStyle(FilledButtonStyle2(color: .accentColor))
                .padding()
                .alert(isPresented: $showAlert2) {
                    Alert(
                        title: Text("\"\(thingsToAdd)\" Added"),
                        message: Text("Check it out in the Magic List!"),
                        dismissButton: .default(Text("OK"), action: {
                            
                        })
                    )
                }
                Spacer()
            }
            if(showLabel1) {
                Text("List Created!")
                    .multilineTextAlignment(.leading)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(8)
                    .font(.title)
            }
            
        }
            .edgesIgnoringSafeArea(.bottom)
            .padding()
            .onTapGesture {
                isFocused = false
            }
            
            .navigationDestination(isPresented: $navigateToToDoListMaker) {
                ToDoListMaker(tasks: tasksViewModel.tasksToDo)
                    .environmentObject(tasksViewModel)
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
    private func compileTasks() {
        tasksViewModel.tasksToDo = userInput.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
           isFocused = false
       }
    
    private func addTask() {
        tasksViewModel.tasksToDo.append(thingsToAdd)
    }
    
}

struct CompileIntoToDo_Previews: PreviewProvider {
    static var previews: some View {
        CompileIntoToDo()
            .environmentObject(TasksViewModel())
    }
}

struct FilledButtonStyle2: ButtonStyle {
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius:20)
                    .fill(color)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 10)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            
            
    }
}
