import SwiftUI

struct MenuPage: View {
    @EnvironmentObject var tasksViewModel: TasksViewModel

    var body: some View {
        
        NavigationView {
            VStack(spacing: 20) {
                HStack {
                    Text("Menu")
                    Image(systemName: "line.horizontal.3.circle")
                }
                .font(.title)
                .foregroundStyle(.tint)
                .symbolRenderingMode(.multicolor)
                
                Divider()
                    .background(Color.accentColor.opacity(0.8))
                    .padding(.horizontal, 40)
                
                Spacer()
                navigationButton(destination: CompileIntoToDo().environmentObject(tasksViewModel), label: "Compile Into Magic", color: .accentColor)
                
                navigationButton(destination: ToDoListMaker(tasks: tasksViewModel.tasksToDo), label: "Magic List", color: .accentColor)
                
                navigationButton(destination: TimeEstimator(), label: "Time Estimator", color: .accentColor)
                
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
                .padding()
                .frame(maxWidth: .infinity)
                .background(color)
                .cornerRadius(10)
        }
        .buttonStyle(FilledButtonStyle(color: .accentColor))
    }

struct FilledButtonStyle: ButtonStyle {
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius:20)
                    .fill(color)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 10)
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
