import Foundation

struct SipCredentials {
    let username: String
    let password: String
    let domain: String
    let displayName: String?

    var userUri: String {
        "sip:\(username)@\(domain)"
    }

    var registrarUri: String {
        "sip:\(domain)"
    }
}

struct SipTransport {
    enum Kind: String {
        case udp
        case tcp
        case tls
    }

    let kind: Kind
    let port: UInt16

    var description: String {
        "\(kind.rawValue.uppercased()) :\(port)"
    }
}

struct SipConfiguration {
    let credentials: SipCredentials
    let transport: SipTransport
    let stunServer: URL?
}
