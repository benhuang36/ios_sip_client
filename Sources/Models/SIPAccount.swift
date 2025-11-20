import Foundation

enum SIPProtocol: String, CaseIterable, Identifiable, Codable {
    case udp
    case tcp

    var id: String { rawValue }

    var label: String {
        switch self {
        case .udp:
            return L10n.Account.protocolUdp
        case .tcp:
            return L10n.Account.protocolTcp
        }
    }
}

struct SIPAccount: Codable, Equatable {
    var displayName: String
    var username: String
    var password: String
    var domain: String
    var transport: SIPProtocol
}
