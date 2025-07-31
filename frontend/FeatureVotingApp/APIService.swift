import Foundation

class APIService {
    let baseURL = "http://127.0.0.1:8000"

    func getFeatures(completion: @escaping ([Feature]) -> Void) {
        guard let url = URL(string: "\(baseURL)/features/") else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                if let features = try? JSONDecoder().decode([Feature].self, from: data) {
                    DispatchQueue.main.async {
                        completion(features)
                    }
                }
            }
        }.resume()
    }

    func addFeature(feature: NewFeature, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)/features/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(feature)

        URLSession.shared.dataTask(with: request) { _, response, _ in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    completion(true)
                }
            } else {
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }.resume()
    }

    func voteFeature(featureId: Int, userId: Int, completion: @escaping (Bool, String?) -> Void) {
        guard let url = URL(string: "\(baseURL)/votes/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let vote = ["feature_id": featureId, "user_id": userId]
        request.httpBody = try? JSONSerialization.data(withJSONObject: vote)

        URLSession.shared.dataTask(with: request) { data, response, _ in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    DispatchQueue.main.async {
                        completion(true, nil)
                    }
                } else if httpResponse.statusCode == 400 {
                    let message: String?
                    if let data = data, let error = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        message = error.detail
                    } else {
                        message = "Vote failed."
                    }
                    DispatchQueue.main.async {
                        completion(false, message)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(false, "Unexpected error occurred.")
                    }
                }
            }
        }.resume()
    }

    struct ErrorResponse: Codable {
        let detail: String
    }

    func getUsers(completion: @escaping ([User]) -> Void) {
        guard let url = URL(string: "\(baseURL)/users/") else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                if let users = try? JSONDecoder().decode([User].self, from: data) {
                    DispatchQueue.main.async {
                        completion(users)
                    }
                }
            }
        }.resume()
    }

    func createUser(user: NewUser, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)/users/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(user)

        URLSession.shared.dataTask(with: request) { _, response, _ in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    completion(true)
                }
            } else {
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }.resume()
    }
}
