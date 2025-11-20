import Foundation
import SwiftUI

@MainActor
final class AppState: ObservableObject {
    @Published var account = SIPAccount(
        displayName: "",
        username: "",
        password: "",
        domain: "",
        transport: .udp
    )

    @Published var isLoggedIn = false
    @Published var callHistory: [CallRecord] = []
    @Published var contacts: [Contact] = []
    @Published var currentCall: CallSession?
    @Published var incomingCall: CallSession?
    @Published var preferences = AppPreferences(
        appearance: .system,
        language: LanguageOption(id: "zh-Hant", displayName: "繁體中文")
    )

    let sipService = SIPService()

    func login() {
        isLoggedIn = sipService.login(account: account)
    }

    func logout() {
        isLoggedIn = false
        currentCall = nil
        incomingCall = nil
        sipService.logout()
    }

    func placeCall(to number: String) {
        let session = sipService.startCall(to: number)
        currentCall = session
        appendCallRecord(from: session)
    }

    func receiveInvite(from number: String) {
        incomingCall = CallSession(id: UUID(), counterpart: number, direction: .inbound, state: .ringing)
    }

    func answerCall() {
        guard var session = incomingCall else { return }
        session.state = .connected
        currentCall = session
        appendCallRecord(from: session)
        incomingCall = nil
    }

    func declineCall() {
        guard let session = incomingCall else { return }
        appendCallRecord(from: CallSession(id: session.id, counterpart: session.counterpart, direction: .inbound, state: .ended))
        incomingCall = nil
    }

    func endCurrentCall() {
        guard var session = currentCall else { return }
        session.state = .ended
        appendCallRecord(from: session)
        currentCall = nil
    }

    func addContact(name: String, number: String) {
        contacts.append(Contact(id: UUID(), name: name, phoneNumber: number))
    }

    func updateContact(_ contact: Contact, name: String, number: String) {
        guard let index = contacts.firstIndex(of: contact) else { return }
        contacts[index].name = name
        contacts[index].phoneNumber = number
    }

    func deleteContact(_ contact: Contact) {
        contacts.removeAll { $0.id == contact.id }
    }

    private func appendCallRecord(from session: CallSession) {
        let record = CallRecord(
            id: UUID(),
            counterpart: session.counterpart,
            direction: session.direction,
            status: session.state,
            timestamp: Date()
        )
        callHistory.insert(record, at: 0)
    }
}
