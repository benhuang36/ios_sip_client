import Foundation

final class SIPService {
    private(set) var isLoggedIn = false

    func login(account: SIPAccount) -> Bool {
        isLoggedIn = !account.username.isEmpty && !account.domain.isEmpty
        return isLoggedIn
    }

    func logout() {
        isLoggedIn = false
    }

    func startCall(to target: String) -> CallSession {
        CallSession(id: UUID(), counterpart: target, direction: .outbound, state: .dialing)
    }

    func sendInviteResponse() {
        // Placeholder for sending SIP signaling
    }
}
