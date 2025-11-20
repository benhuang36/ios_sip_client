import Foundation

struct Contact: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var phoneNumber: String
}
