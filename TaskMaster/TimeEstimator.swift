import SwiftUI
import SwiftData

struct TimeEstimator: View {
    @State private var userInput: String = ""
        @State private var estimatedTime: Int?
        let estimator = TaskTimeEstimator()

        var body: some View {
            VStack(spacing: 20) {
                Divider()
                Text("Time Estimator")
                    .font(.largeTitle)
                    .bold()
                Divider()
                Spacer()
                TextField("Enter your task description", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                VStack {
                    Button(action: {
                        estimatedTime = estimator.estimateTime(for: userInput)
                        userInput=""
                    }) {
                        Text("    Estimate Time    ")
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color.accentColor)
                            .cornerRadius(20)
                    }
                    
                    .padding()
                .buttonStyle(FilledButtonStyle2(color: .accentColor))
                }
                if(estimatedTime==0) {
                    Text("No estimate available for this task")
                        .font(.title2)
                }
                else if let time = estimatedTime {
                    Text("Estimated time: \(time) minutes")
                        .font(.title2)
                } else {
                    Text("No estimate available for this task")
                        .font(.title2)
                }
                Spacer()
                Spacer()
            }
            .padding()
        }
}

#Preview {
    TimeEstimator()
}
