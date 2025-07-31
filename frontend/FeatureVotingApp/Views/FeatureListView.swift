import SwiftUI

struct FeatureListView: View {
    @State private var features: [Feature] = []
    @State private var users: [User] = []
    @State private var selectedUserId: Int? = nil
    @State private var showAlert = false
    @State private var alertMessage = ""

    let api = APIService()

    var body: some View {
        NavigationView {
            VStack {
                // User selector
                Picker("Select User", selection: $selectedUserId) {
                    ForEach(users) { user in
                        Text(user.name).tag(user.id as Int?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()

                List {
                    ForEach(features) { feature in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(feature.title)
                                    .font(.headline)
                                if let desc = feature.description {
                                    Text(desc)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            Spacer()
                            Button(action: {
                                if let uid = selectedUserId {
                                    api.voteFeature(featureId: feature.id, userId: uid) { success, message in
                                        if success {
                                            loadData()
                                        } else {
                                            alertMessage = message ?? "Vote failed."
                                            showAlert = true
                                        }
                                    }
                                }
                            }) {
                                Text("👍 \(feature.votes_count)")
                            }
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Vote Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                            }
                        }
                    }
                }
                .navigationTitle("Features")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        NavigationLink(destination: AddFeatureView(userId: selectedUserId ?? 1, onAdd: {
                            loadData()
                        })) {
                            Text("Add Feature")
                        }
                        NavigationLink(destination: CreateUserView(onUserCreated: {
                            loadUsers()
                        })) {
                            Text("Add User")
                        }
                    }
                }
            }
            .onAppear {
                loadData()
                loadUsers()
            }
        }
    }

    func loadData() {
        api.getFeatures { fetched in
            self.features = fetched
        }
    }

    func loadUsers() {
        api.getUsers { fetchedUsers in
            self.users = fetchedUsers
            if selectedUserId == nil, let firstUser = fetchedUsers.first {
                selectedUserId = firstUser.id
            }
        }
    }
}
