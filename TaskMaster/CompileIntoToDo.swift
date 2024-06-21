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
    @State private var alertTitle2=""
    @State private var alertMessage2=""
    
    @FocusState private var isSingleItemFocused: Bool
    @ObservedObject private var keyboardResponder = KeyboardResponder()
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
                            message: Text("Your list is now in the To-Do List"),
                            dismissButton: .default(Text("OK"), action: {
                                
                            })
                        )
                    }
                
                Button(action: {
                    compileTasks()
                    showAlert=true
                    showLabel1=true
                    userInput="";
                }) {
                    Text("Turn This Into A List")
                        .foregroundStyle(.white)
                        .padding()
                        .cornerRadius(20)
                        .padding(.horizontal, 8)
                }
                .buttonStyle(FilledButtonStyle2(color: .accentColor))
                .padding()
                
                Spacer()
                VStack() {
                    TextField("Add a single item", text: $thingsToAdd)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .focused($isSingleItemFocused) // Focus state for single item text field
                    
                    Button(action: {
                        if !thingsToAdd.isEmpty {
                            addTask()
                            alertTitle2="\"\(thingsToAdd)\" Added"
                            alertMessage2="Check it out in the To-Do List!"
                            showAlert2=true
                            thingsToAdd="";
                            isSingleItemFocused=false;
                        } else {
                            alertTitle2="Error"
                            alertMessage2="Please enter an item"
                            showAlert2=true
                        }
                    }) {
                        Text("Submit")
                            .foregroundStyle(.white)
                            .padding()
                            .cornerRadius(20)
                            .padding(.horizontal, 60)
                        }
                        .buttonStyle(FilledButtonStyle2(color: .accentColor))
                        .padding()
                        .alert(isPresented: $showAlert2) {
                            Alert(
                                title: Text(alertTitle2),
                                message: Text(alertMessage2),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                    }
                    .padding(.bottom, isSingleItemFocused ? keyboardResponder.currentHeight : 0) // Adjust padding
                    .animation(.easeOut(duration: 0.16), value: keyboardResponder.currentHeight) // Add animation
                    
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
            isSingleItemFocused = false // Unfocus the single item text field
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
