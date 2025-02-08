import SwiftUI
import MapKit
import CoreLocation

// MARK: - User Data Model
struct User: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let avatarImage: String // User's profile image
    let hungerLevel: Int // Status: Food
    let studyLevel: Int  // Status: Study
}

// MARK: - Home Page View (Displays Users with Avatars & Status Bars on the Map)
struct HomePageView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var selectedTab: Int = 1

    // Default CMU region
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.4433, longitude: -79.9436),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )

    // 4 Users with fixed locations
    @State private var users: [User] = [
        User(name: "Fish", coordinate: CLLocationCoordinate2D(latitude: 40.4445, longitude: -79.9450), avatarImage: "fish_icon", hungerLevel: 80, studyLevel: 30),
        User(name: "Octopus", coordinate: CLLocationCoordinate2D(latitude: 40.4430, longitude: -79.9462), avatarImage: "octopus_icon", hungerLevel: 50, studyLevel: 90),
        User(name: "Bear", coordinate: CLLocationCoordinate2D(latitude: 40.4422, longitude: -79.9440), avatarImage: "bear_icon", hungerLevel: 20, studyLevel: 60),
        User(name: "Cat", coordinate: CLLocationCoordinate2D(latitude: 40.4438, longitude: -79.9425), avatarImage: "cat_icon", hungerLevel: 100, studyLevel: 50)
    ]

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                // The Map View with User Avatars & Status Bars
                Map(coordinateRegion: $region, annotationItems: users) { user in
                    MapAnnotation(coordinate: user.coordinate) {
                        VStack(spacing: 6) {
                            // Status Bars (Food & Study)
                            StatusBarView(statusValue: user.hungerLevel, iconName: "hunger_icon", barColor: Color(red: 200 / 255, green: 246 / 255, blue: 227 / 255)) // Light Pink
                            StatusBarView(statusValue: user.studyLevel, iconName: "study_icon", barColor: Color(red: 191 / 255, green: 236 / 255, blue: 255 / 255)) // Light Blue

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
            }
            .toolbar {
                // Profile Button with Anime Avatar
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: ProfileView(viewModel: viewModel)) {
                        Image("anime_avatar") // Replace with uploaded anime avatar
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 3)
                    }
                }

                // Settings Button (Sign Out Moved Here)
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape.fill") // Settings Icon
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

// MARK: - Status Bar UI Component
struct StatusBarView: View {
    var statusValue: Int
    var iconName: String // Custom image for the status icon
    var barColor: Color // Custom bar color

    var body: some View {
        HStack(spacing: 6) {
            // Custom Icon (Left Side)
            Image(iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)

            // Status Bar
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.8)) // Background Bar
                    .frame(width: 180, height: 15)

                RoundedRectangle(cornerRadius: 8)
                    .fill(barColor) // Updated colors
                    .frame(width: CGFloat(statusValue) * 1.8, height: 15)
            }
        }
        .padding(.horizontal, 8)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.9)))
    }
}
