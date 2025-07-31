import SwiftUI

struct CreateUserView: View {
    @State private var name = ""
    @State private var email = ""
    let api = APIService()
    var onUserCreated: () -> Void

    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Enter name", text: $name)
            }
            Section(header: Text("Email")) {
                TextField("Enter email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
            }
            Button("Create User") {
                let newUser = NewUser(name: name, email: email)
                api.createUser(user: newUser) { success in
                    if success {
                        onUserCreated()
                    }
                }
            }
        }
        .navigationTitle("New User")
    }
}
