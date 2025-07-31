import SwiftUI

struct AddFeatureView: View {
    @State private var title = ""
    @State private var description = ""
    let userId: Int
    let api = APIService()
    var onAdd: () -> Void

    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Feature title", text: $title)
            }
            Section(header: Text("Description")) {
                TextField("Feature description", text: $description)
            }
            Button("Submit") {
                let newFeature = NewFeature(title: title, description: description, created_by: userId)
                api.addFeature(feature: newFeature) { success in
                    if success {
                        onAdd()
                    }
                }
            }
        }
        .navigationTitle("Add Feature")
    }
}



