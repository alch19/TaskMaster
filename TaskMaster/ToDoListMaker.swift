import SwiftUI

struct ToDoListMaker: View {
    var tasks: [String]
    
    @State private var showMenuPage=false
    var body: some View {
        List(tasks, id: \.self) { task in
            Text(task)
        }
        .navigationTitle("To-Do List")
        
        
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
    }

struct ToDoListMaker_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListMaker(tasks: ["Task 1", "Task 2"])
    }
}
