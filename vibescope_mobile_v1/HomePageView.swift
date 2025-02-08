import SwiftUI
import MapKit

struct HomePageView: View {
    @ObservedObject var viewModel: ViewModel

    // Define a region centered around CMU campus
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.4433, longitude: -79.9436), // CMU coordinates
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )
    
    // Selected tab state
    @State private var selectedTab: Int = 1

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                // The Map View
                Map(coordinateRegion: $region)
                    .ignoresSafeArea()

                // Bottom Navigation Bar
                VStack(spacing: 0) {
                    Spacer()
                    
                    HStack(spacing: 0) { // No gaps between buttons
                        Button(action: { selectedTab = 0 }) {
                            Image("cat_eating")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight: 60) // Maintain big icons
                                .opacity(selectedTab == 0 ? 1.0 : 0.5)
                        }

                        Button(action: { selectedTab = 1 }) {
                            Image("cat_sword")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight: 65) // Center icon slightly larger
                                .opacity(selectedTab == 1 ? 1.0 : 0.5)
                        }

                        Button(action: { selectedTab = 2 }) {
                            Image("fish")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight: 60) // Maintain big icons
                                .opacity(selectedTab == 2 ? 1.0 : 0.5)
                        }
                    }
                    .frame(height: 85) // 🔥 Reduced from 120 to make it thinner
                    .frame(maxWidth: .infinity) // Full width
                    .background(Color.white) // Solid background color
                    .ignoresSafeArea(edges: .bottom) // Forces it to touch the bottom of the screen
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom) // Forces the VStack to stay at the bottom
            }
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
