import SwiftUI

struct ContentView: View {
    @State private var showSplash = true
    @State private var navigateToMenuPage = false
    
    var body: some View {
        ZStack {
            if showSplash {
                HomeLogoView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                self.showSplash = false
                                self.navigateToMenuPage = true
                            }
                        }
                    }
            } else if navigateToMenuPage {
                MenuPage()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
