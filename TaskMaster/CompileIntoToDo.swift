import SwiftUI

struct CompileIntoToDo: View {
    @State private var userInput=""
    @FocusState private var isFocused: Bool
    @State private var tasksToDo: [String] = []
    
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
            
            Button(action: compileTasks) {
                Text("Turn This Into A List")
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.accentColor)
                    .cornerRadius(20)
            }
            .padding()
        }
    }
    private func compileTasks() {
           tasksToDo = userInput.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
           isFocused = false
       }
    
}

#Preview {
    CompileIntoToDo()
}
