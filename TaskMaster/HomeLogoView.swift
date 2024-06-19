import SwiftUI
import SwiftData

struct HomeLogoView: View {
    var body: some View {
        Image("Logo")
            .resizable()
            .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    HomeLogoView()
}
