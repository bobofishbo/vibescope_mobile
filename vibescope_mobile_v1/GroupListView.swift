import SwiftUI

struct GroupsListView: View {
    @State var groups: [Group] = []

    var body: some View {
        List {
            ForEach(groups) { group in
                VStack(alignment: .leading) {
                    Text(group.group_name)
                        .font(.headline)
                    Text("Members: \(group.user_id_1), \(group.user_id_2), \(group.user_id_3), \(group.user_id_4)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }

        .overlay {
            if groups.isEmpty {
                ProgressView()
            }
        }
        .task {
            do {
                let response = try await supabase
                    .from("groups") // Ensure this matches your Supabase table name
                    .select()
                    .execute()

                groups = try JSONDecoder().decode([Group].self, from: response.data) // ✅ Use data directly
            } catch {
                print("Error fetching groups:", error)
            }

        }
    }
}

#Preview {
    GroupsListView() // Change to any view you want to preview
}
