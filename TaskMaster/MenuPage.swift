import SwiftUI
import SwiftData

struct MenuPage: View {
    @EnvironmentObject var tasksViewModel: TasksViewModel

    /*var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color(red: 0.160, green: 0.180, blue: 0.250), Color(red: 0.650, green: 0.660, blue: 0.710)]), startPoint: .top, endPoint: .bottom)
    }*/
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 20) {
                Text("TaskMaster")
                    .font(.largeTitle)
                    .foregroundStyle(.mint)
                Divider()
                HStack {
                    Text("Menu")
                    Image(systemName: "line.horizontal.3.circle")
                }
                .font(.title)
                .foregroundStyle(.tint)
                .symbolRenderingMode(.multicolor)
                Divider()
                Spacer()
                navigationButton(destination: CompileIntoToDo().environmentObject(tasksViewModel), label: "Compile Into List", color: .accentColor)
                
                navigationButton(destination: ToDoListMaker(tasks: tasksViewModel.tasksToDo), label: "To-Do List", color: .accentColor)
                
                navigationButton(destination: TimeEstimator(), label: "Time Estimator", color: .accentColor)
                
                Spacer()
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

private func navigationButton<Destination: View>(destination: Destination, label: String, color: Color) -> some View {
        return NavigationLink(destination: destination) {
            Text(label)
                .foregroundColor(.white)
                .font(.title)
                .padding()
                .frame(maxWidth: .infinity)
                .cornerRadius(10)
        }
        .buttonStyle(FilledButtonStyle(color: .accentColor))
    }

struct FilledButtonStyle: ButtonStyle {
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.top, 5)
            .padding(.bottom, 5)
            .background(
                RoundedRectangle(cornerRadius:15)
                    .fill(color)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 10)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            
            
    }
}

struct MenuPage_Previews: PreviewProvider {
    static var previews: some View {
        MenuPage()
            .environmentObject(TasksViewModel())
    }
}
