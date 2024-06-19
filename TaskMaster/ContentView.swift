import SwiftUI

struct ContentView: View {
    @State private var showSplash = true
    @State private var navigateToMenuPage = false
    
    var body: some View {
        ZStack {
            if showSplash {
                HomeLogoView()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                    .background(.white)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { 
                            withAnimation {
                                self.showSplash = false
                                self.navigateToMenuPage = true
                            }
                        }
                    }
            } else {
                MenuPage()
                    .environmentObject(TasksViewModel())
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TasksViewModel())
    }
}
