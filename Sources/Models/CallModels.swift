import Foundation

enum CallDirection: String, Codable {
    case inbound
    case outbound
}

enum CallState: String, Codable {
    case idle
    case dialing
    case ringing
    case connected
    case ended
}

struct CallRecord: Identifiable, Codable {
    let id: UUID
    var counterpart: String
    var direction: CallDirection
    var status: CallState
    var timestamp: Date
}

struct CallSession: Identifiable, Codable {
    let id: UUID
    var counterpart: String
    var direction: CallDirection
    var state: CallState
}
