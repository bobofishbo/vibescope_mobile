import SwiftUI

struct HomePageView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            VStack {
                Text("🎉 Welcome to VibeScope!")
                    .font(.largeTitle)
                    .padding()

                Text("Explore your groups and stay connected.")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileView(viewModel: viewModel)) {
                        Label("Profile", systemImage: "person.circle")
                    }
                }
            }
        }
    }
}

#Preview {
    HomePageView(viewModel: ViewModel())
}
