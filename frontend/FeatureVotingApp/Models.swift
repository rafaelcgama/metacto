import Foundation

struct Feature: Identifiable, Codable {
    let id: Int
    let title: String
    let description: String?
    let votes_count: Int
}

struct NewFeature: Codable {
    let title: String
    let description: String?
    let created_by: Int
}

struct User: Identifiable, Codable {
    let id: Int
    let name: String
    let email: String
}

struct NewUser: Codable {
    let name: String
    let email: String
}
