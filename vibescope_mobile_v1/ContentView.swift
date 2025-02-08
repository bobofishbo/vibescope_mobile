import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel() // Manages authentication state

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isAuthenticated {
                    // ✅ If authenticated, show GroupsListView
                    HomePageView(viewModel: viewModel)

                } else {
                    // 🔐 If not authenticated, show sign-in/sign-up UI
                    VStack {
                        Text("Welcome to VibeScope")
                            .font(.largeTitle)
                            .padding()

                        Button("Sign In") {
                            viewModel.showingAuthView = true
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }
                }
            }
            .toolbar {
                if viewModel.isAuthenticated {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            Task {
                                try await viewModel.signOut()
                                await viewModel.isUserAuthenticated()
                            }
                        } label: {
                            Text("Sign Out")
                        }
                    }
                }
            }
            .task {
                await viewModel.isUserAuthenticated()
            }

            .sheet(isPresented: $viewModel.showingAuthView) {
                AuthView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
