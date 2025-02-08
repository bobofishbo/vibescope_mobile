import SwiftUI
import MapKit
import CoreLocation

// MARK: - Location Manager (Handles real-time user location updates)
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    @Published var userLocation: CLLocationCoordinate2D? = nil

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.userLocation = location.coordinate
        }
    }
}

// MARK: - User Data Model
struct User: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let avatarImage: String // User's profile image
    let statusBarImage: String // Corresponding 血条 image
}

// MARK: - Home Page View (Displays Users with Avatars & Status Bars on the Map)
struct HomePageView: View {
    @ObservedObject var viewModel: ViewModel
    @StateObject private var locationManager = LocationManager()
    @State private var selectedTab: Int = 1

    // Default CMU region
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.4433, longitude: -79.9436),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )

    // 4 Random Users Placed on CMU Map
    @State private var users: [User] = [
        User(name: "Fish", coordinate: CLLocationCoordinate2D(latitude: 40.4445, longitude: -79.9450), avatarImage: "fish_icon", statusBarImage: "status_bar_fish"),
        User(name: "Octopus", coordinate: CLLocationCoordinate2D(latitude: 40.4430, longitude: -79.9462), avatarImage: "octopus_icon", statusBarImage: "status_bar_octopus"),
        User(name: "Bear", coordinate: CLLocationCoordinate2D(latitude: 40.4422, longitude: -79.9440), avatarImage: "bear_icon", statusBarImage: "status_bar_bear"),
        User(name: "Cat", coordinate: CLLocationCoordinate2D(latitude: 40.4438, longitude: -79.9425), avatarImage: "cat_icon", statusBarImage: "status_bar_cat")
    ]

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                // The Map View with User Avatars & Status Bars
                Map(coordinateRegion: $region, annotationItems: users) { user in
                    MapAnnotation(coordinate: user.coordinate) {
                        VStack(spacing: 5) {
                            // Status Bar (血条)
                            Image(user.statusBarImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 55) // Adjusted for better fit

                            // User Avatar
                            Image(user.avatarImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 65, height: 65)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .shadow(radius: 5)
                        }
                    }
                }
                .ignoresSafeArea()
                .onAppear {
                    if let userLocation = locationManager.userLocation {
                        region.center = userLocation
                    }
                }
                .onReceive(locationManager.$userLocation) { newLocation in
                    if let newLocation = newLocation {
                        region.center = newLocation
                    }
                }

                // Bottom Navigation Bar
                VStack(spacing: 0) {
                    Spacer()

                    HStack(spacing: 0) {
                        Button(action: { selectedTab = 0 }) {
                            Image("cat_eating")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight: 65)
                                .opacity(selectedTab == 0 ? 1.0 : 0.5)
                        }

                        Button(action: { selectedTab = 1 }) {
                            Image("cat_sword")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight: 70)
                                .opacity(selectedTab == 1 ? 1.0 : 0.5)
                        }

                        Button(action: { selectedTab = 2 }) {
                            Image("fish")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight: 65)
                                .opacity(selectedTab == 2 ? 1.0 : 0.5)
                        }
                    }
                    .frame(height: 90)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .ignoresSafeArea(edges: .bottom)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
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
